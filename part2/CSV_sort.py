from pyspark.sql import SparkSession
from pyspark import SparkConf, SparkContext
import commands

#Fetch private IP address of the master. NOTE: we assume eth1 references the private IP. Please change if its not the case
ip_addr = commands.getoutput("/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'")
url = "hdfs://"+ip_addr+":9000/"  # url of hdfs
conf = SparkConf().setAppName("SimpleApp").setMaster("spark://"+ ip_addr +":7077")
sc = SparkContext.getOrCreate(conf=conf)#Get spark context object
rdd1 = sc.textFile(url+"input") #read input from hdfs 
rdd1 = rdd1.filter(lambda l: not l.startswith("battery_level")) #remove the heade
rdd1 = rdd1.sortBy(lambda l: (l.split(",")[2], l.split(",")[-1])) #sort by a composite key
rdd1.saveAsTextFile (url+"output") #save output to hdfs
print("Saved sorted data to hdfs file")
