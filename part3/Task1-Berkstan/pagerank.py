from pyspark.sql import SparkSession
from pyspark import SparkConf, SparkContext
from operator import add
import commands

# get the ip address corresponding to eth1 interface(change the code if you want a different IP addres)
ip_addr = commands.getoutput("/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'")

### hdfs url 
url = "hdfs://"+ip_addr+":9000/" 
conf = SparkConf().setAppName('PageRank_web-berkstan').setMaster('spark://'+ ip_addr +':7077')
sc = SparkContext.getOrCreate(conf=conf) 	#initialize spark context object


lines = sc.textFile(url+'input').filter(lambda l: not l.startswith('#')) # get the input from hdfs and filter the commented lines

# get the links rdd having the rows of the form (source_url, list(dest_urls))
links = lines.map(lambda l: (l.split('\t')[0],l.split('\t')[1])).partitionBy(200).distinct().groupByKey().cache() 

ranks = links.keys().map(lambda l: (l,1)).partitionBy(200)# initialize source urls rank to 1

for i in range(10):
  contribs = links.join(ranks).flatMap(lambda l: map(lambda a: (a,l[1][1]/len(l[1][0])),l[1][0])) # get the rows of form (dest_url, r_source/n_neighbors)
  ranks = contribs.reduceByKey(add).mapValues(lambda l: 0.15 + 0.85*l).partitionBy(200) # reduce to get rank of all destinations urls

ranks.saveAsTextFile(url+'output') # save the final ranks rdd in hdfs
print("Saved output to folder 'output'")
