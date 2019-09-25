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
 elif ':' in out: #It will discard those lines which have ':' but not 'category:'
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
ip_addr = commands.getoutput("/sbin/ifconfig").split("\n")[1].split()[1][5:]
print(ip_addr)
url = "hdfs://"+ip_addr+":9000/"
conf = SparkConf().setAppName('Complete_run_5_iterations_nopartition').setMaster('spark://'+ ip_addr +':7077')
#conf = SparkConf().setAppName('PageRank')
sc = SparkContext(conf=conf)

## Get the output of shell comamnd "hdfs dfs -ls -C /page_rank_data/enwiki-pages-articles" and collect it in `files`
#files = commands.getoutput('hdfs dfs -ls -C /enwiki-pages-articles')
#files = files.split('\n')
#files = filter(lambda path: 'link-enwiki' in path, files) #keep a file name in the list only if it is a valid dataset file

#Iterate over the files in the list:
#(i) Initially, `lines` stores the pointer corresponding to the RDD created from first file in the list
#(ii) `lines` pointer is then incrementally updated, so that the resulting pointer corresponds to the RDD created from all files in the list

#for idx, File in enumerate(glob.glob('/proj/uwmadison744-f19-PG0/data-part3/enwiki-pages-articles'+'/link-enwiki*')):
#for idx, File in enumerate(files):
# if (idx == 0):
#  lines = sc.textFile('hdfs://'+ip_addr+':9000'+File).map(lambda l: l.lower()).filter(preprocess)
# elif idx<53:
#  lines += sc.textFile('hdfs://'+ip_addr+':9000'+File).map(lambda l: l.lower()).filter(preprocess)
# else:
#  break

lines = sc.textFile('/proj/uwmadison744-f19-PG0/data-part3/enwiki-pages-articles/link-enwiki*').map(lambda l: l.lower()).filter(preprocess)

# I am following the pagerank notation from the Spark paper mentioned below:
# Resilient Distributed Datasets: A Fault-Tolerant Abstraction for In-Memory Cluster Computing

# `links` is an RDD with each record of the form: (URL, outlinks)
links = lines.map(lambda l: (l.split('\t')[0],l.split('\t')[1])).partitionBy(int(100)).distinct().groupByKey()
# `ranks` is an RDD of (URL, rank) pairs with rank initialized to 1 for each URL
ranks = links.keys().map(lambda l: (l,1)).partitionBy(int(100))

for i in range(5):
 contribs = links.join(ranks).flatMap(lambda l: map(lambda a: (a,float(l[1][1])/len(l[1][0])),l[1][0]))# Build an RDD of (targetURL, float) pairs with the contributions sent by each page
 ranks = contribs.reduceByKey(add).mapValues(lambda l: 0.15 + 0.85*l).partitionBy(int(100)) #Sum contributions by URL and get new ranks
 ranks = links.keys().keyBy(lambda l:l).leftOuterJoin(ranks).map(left_only)

ranks.saveAsTextFile(url+'LeftRanks_Output') #save the RDD in HDFS at /LeftRanks_Output
