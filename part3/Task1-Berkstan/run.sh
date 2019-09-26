INPUT=$1  	# name of the input file to apply pagerank algorithm on
OUTPUT=$2 	# name of the output file
if [ "$INPUT" = "" ];then
INPUT="web-BerkStan.txt"
fi

hdfs dfs -rm -R /input 		# remove the input directory if it exists in hdfs
hdfs dfs -put $INPUT /input	# store the input file in a hdfs directory called "input"  
hdfs dfs -rm -R /output		# delete the hdfs directory named "output" if it exists` 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit pagerank.py # run the spark-submit job which stores the output in hdfs directory named "output"

if [ "$OUTPUT" = "" ];then
OUTPUT="output"
fi

rm -rf $OUTPUT 		# remove the output directory if it already exists
hdfs dfs -get /output $OUTPUT	# get the directory from hdfs directory into a folder named $OUTPUT in local fs
