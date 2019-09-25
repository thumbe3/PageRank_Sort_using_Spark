INPUT=$1
OUTPUT=$2
partitions=("6 yes" "10 yes" "20 yes" "50 yes" "100 yes" "200 yes" "6 no" "10 no" "20 no" "50 no" "100 no" "200 no")
for i in "${partitions[@]}"; do
 hdfs dfs -rm -R /LeftRanks_Output
 /mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit pagerank_large_keyBy.py $i
 if [ "$OUTPUT" = "" ];then
 OUTPUT="LeftRanks_Output"
 fi
 rm -rf $OUTPUT
 hdfs dfs -get /LeftRanks_Output $OUTPUT
done
