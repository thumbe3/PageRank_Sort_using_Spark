#!/bin/bash
INPUT=${1:-}
if [ "$INPUT" = "" ];then
  wget -N http://pages.cs.wisc.edu/~shivaram/cs744-fa18/assets/export.csv 	#download  the input file
  INPUT="export.csv"
fi
  
hdfs dfs -rm -R /input 			 # check file with name "input" already exists if yes delete it
hdfs dfs -put $INPUT /input	 	# create the file with name input from the file given by the user(or export.csv)
hdfs dfs -rm -R /output 		# check if file with name "output" already exists if yes delete it

#### you can change this line if your spark is locatd in a different location
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit --name="sort data" CSV_sort.py	# run the spark job and save the output file in hdfs
if [ "$OUTPUT" = "" ];then
OUTPUT="output"
fi
hdfs dfs -get /output output	#get the file from hdfs into local fs and save it in the folder named output
