from pyspark.sql import SparkSession
from pyspark import SparkConf, SparkContext
from operator import add
import commands
import glob
import sys


def preprocess(line):
 if line.startswith('#'): # This preprocesses the file to not include any comments
  return False
 out = line.split('\t')[1]
 if 'category:' in out: #This will retain the lines which have 'category:' in it
  return True
 elif ':' in out: # It will discard those lines which have ':' but not 'category:'
  return False
 else:
  return True


def left_only(kvw):
 if (kvw[1][1] is None): #If a source article does not appear as destination article, they have second value as 'None' after leftOuterJoin()
  return (kvw[0],0.15) #I set the rank of such articles to 0.15
 else:
  return (kvw[0], kvw[1][1]) #Other articles' ranks are updated from the contributions they receive


def key_partitioner(url): #using hash partitioner on `url` (i.e the key in `links` RDD)
 return hash(url)

## Create SparkContext by setting master's IP:PORT through sc.setMaster()
ip_addr = commands.getoutput("/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'")
url = "hdfs://"+ip_addr+":9000/"
conf = SparkConf().setAppName('Custom_partition_'+sys.argv[1]+'_'+sys.argv[2]).setMaster('spark://'+ ip_addr +':7077')
sc = SparkContext.getOrCreate(conf=conf)



lines = sc.textFile('/proj/uwmadison744-f19-PG0/data-part3/enwiki-pages-articles/link-enwiki*').map(lambda l: l.lower()).filter(preprocess)

# persist the RDD based on the user argument
if sys.argv[2]=="yes":
        links = lines.map(lambda l: (l.split('\t')[0],l.split('\t')[1])).partitionBy(int(sys.argv[1])).distinct().groupByKey().cache()
else:
        links = lines.map(lambda l: (l.split('\t')[0],l.split('\t')[1])).partitionBy(int(sys.argv[1])).distinct().groupByKey()


# `ranks` is an RDD of (URL, rank) pairs with rank initialized to 1 for each URL
ranks = links.keys().map(lambda l: (l,1)).partitionBy(int(sys.argv[1]))
for i in range(5):
 contribs = links.join(ranks).flatMap(lambda l: map(lambda a: (a,float(l[1][1])/len(l[1][0])),l[1][0])) # Build an RDD of (targetURL, float) pairs with the contributions sent by each page
 ranks = contribs.reduceByKey(add).mapValues(lambda l: 0.15 + 0.85*l).partitionBy(int(sys.argv[1])) # Sum contributions by URL and get new ranks

 # ranks = links.keys().keyBy(lambda l:l).leftOuterJoin(ranks).map(left_only) # perform a left outer join to assign 0.15 rank to destination articles that donot appear as source articles
 # commenting out this line results in performance gain so we commented that line at the cost of not getting ranks for destination articles that donot appear as source articles 


ranks.saveAsTextFile('LeftRanks_Output') # save the output RDD in the folder named "output"
