NPUT=$1
OUTPUT=$2
partitions=( "50" "100" "200")
for i in "${partitions[@]}"; do
 hdfs dfs -rm -R /LeftRanks_Output
 ~/spark-2.4.4-bin-hadoop2.7/bin/spark-submit pagerank_nopartition.py $i
 if [ "$OUTPUT" = "" ];then
 OUTPUT="LeftRanks_Output"
 fi
 rm -rf $OUTPUT
 hdfs dfs -get /LeftRanks_Output $OUTPUT
done
