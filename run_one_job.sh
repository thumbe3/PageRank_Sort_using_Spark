INPUT1=$1
INPUT2=$2
INPUT3=$3
hdfs dfs -rm -R /LeftRanks_Output
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit $INPUT1 $INPUT2 $INPUT3
if [ "$OUTPUT" = "" ];then
OUTPUT="LeftRanks_Output"
fi
rm -rf $OUTPUT
hdfs dfs -get /LeftRanks_Output $OUTPUT
