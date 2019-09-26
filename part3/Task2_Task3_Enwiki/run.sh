file=$1 	# name of the file it is one of "custom_partition_pagerank.py" " default_partition_pagerank.py"
partitions=$2  	# number of partitions 
persist=$3 	# "yes" if you want to persist the RDD "no" otherwise

# default values for the input
if [ "$partitions" = "" ];then
partitions=200
fi

if [ "$persist" = "" ];then
persist="yes"
fi

if [ "$file" = "" ];then
file=default_partition_pagerank.py
fi

rm -rf output 
# run the spark submit job
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit $file $partitions $persist      # run the spark-submit job that takes partitions and persistence as the input

