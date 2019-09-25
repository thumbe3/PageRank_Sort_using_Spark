sudo apt-get update --fix-missing
sudo apt-get install openjdk-8-jdk
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub 
vim ~/.ssh/authorized_keys 
sudo mkfs.ext4 /dev/xvda4
sudo mkdir -p /mnt/data
sudo mount /dev/xvda4 /mnt/data 
df -h | grep data
chown -R varsha: /mnt/data/
sudo chown -R varsha: /mnt/data/
chmod -R 777 /mnt/data/
cd /mnt/data/
wget http://apache.mirrors.hoobly.com/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
tar zvxf hadoop-3.1.2.tar.gz
c220g1-031123vm-1.wisc.cloudlab.us
vim hadoop-3.1.2/etc/hadoop/core-site.xml 
vim hadoop-3.1.2/etc/hadoop/hdfs-site.xml 
update-alternatives --display java
vim hadoop-3.1.2/etc/hadoop/hadoop-env.sh 
vim hadoop-3.1.2/etc/hadoop/workers 
mkdir hadoop-3.1.2/data
mkdir hadoop-3.1.2/data/namenode
mkdir hadoop-3.1.2/data/datanode
jps
hdfs namenode -format
export PATH=$PATH/mnt/data/hadoop-3.1.2/bin
export PATH=$PATH/mnt/data/hadoop-3.1.2/sin
export PATH=$PATH/mnt/data/hadoop-3.1.2/sbin
hdfs namenode -format
exit
cd /mnt/data/
ls
export PATH=$PATH:/mnt/data/hadoop-3.1.2/sbin
export PATH=$PATH:/mnt/data/hadoop-3.1.2/bin
hdfs
hdfs namenode -format
start-dfs.sh
jps
wget http://mirror.metrocast.net/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
tar zvxf spark-2.4.4-bin-hadoop2.7.tgz
vim spark-2.4.4-bin-hadoop2.7/conf/slaves
spark-2.4.4-bin-hadoop2.7/sbin/start-all.sh
jps
exit
ls
vim pagerank_large_keyBy.py
vim part3_large.sh 
jps
cd /mnt/data/
vim spark-2.4.4-bin-hadoop2.7/conf/spark-env.sh
chmod +x spark-2.4.4-bin-hadoop2.7/conf/spark-env.sh
vim spark-2.4.4-bin-hadoop2.7/conf/spark-defaults.conf
vim spark-2.4.4-bin-hadoop2.7/conf/spark-defaults.conf.template 
vim spark-2.4.4-bin-hadoop2.7/conf/spark-defaults.conf
ls
mkdir tmp
mkdir spark_logs
spark-2.4.4-bin-hadoop2.7/sbin/start-history-server.sh 
jps
exit
ls
exit
vim pagerank_large_keyBy.py 
exit
jps
ls
vim pagerank_large_keyBy.py 
vim nopartition.sh
vim pagerank_nopartition.py
vim nopartition.sh
vim pagerank_large_keyBy.py 
vim pagerank_nopartition.py
vim nopartition.sh
vim pagerank_nopartition.py
vim nopartition.sh
hdfs
export PATH=$PATH:/mnt/data/hadoop-3.1.2/sbin
export PATH=$PATH:/mnt/data/hadoop-3.1.2/bin
hdfs
spark-2.4.4-bin-hadoop2.7/bin/spark-submit pagerank_nopartition.py
cd /mnt/data/
spark-2.4.4-bin-hadoop2.7/bin/spark-submit pagerank_nopartition.py
spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_nopartition.py 
vim ~/pagerank_large_keyBy.py 
vim ~/pagerank_nopartition.py 
hdfs dfs -ls /
hdfs dfs -rm R /LeftRanks_Output
hdfs dfs -rm -R /LeftRanks_Output
spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_nopartition.py 
vim ~/pagerank_nopartition.py 
vim ~/pagerank_large_keyBy.py 
vim ~/pagerank_nopartition.py 
hdfs dfs -rm -R /LeftRanks_Output
spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_nopartition.py 
exit
cd ~
ls
cd /mnt/data
ls
cd spark-2.4.4-bin-hadoop2.7/
cd conf/
ls
vim spark-defaults.conf
cd ..
cd sbin/
./start-history-server.sh 
vim spark-defaults.conf
cd ..
cd conf
vim spark-defaults.conf
cd ../..
ls
cd spark_logs/
ls
cd ..
cd spark-2.4.4-bin-hadoop2.7/
cd conf/
vim spark-defaults.conf
cd ..
cd sbin/
./start-history-server.sh 
ifconfig
cd ~
ls
cd spark-logs/
ls
cp -a . /mnt/data/spark_logs/
cd ~
ls
systemctl -i reboot
reboot
cd ~
ls
cd /mnt/data/
ls
cd spark_logs/
ls
cd ~
ls
cat part3_large.sh 
vim pagerank_large_keyBy.py 
vim run_one_job.sh
vim pagerank_large_keyBy.py 
vim run_one_job.sh
vim pagerank_large_keyBy.py 
vim run_one_job.sh
vim pagerank_large_keyBy.py 
chmod +x ./run_one_job.sh 
./run_one_job.sh ./pagerank_large_keyBy.py 200 yes
hdfs
~/.bashrc
vim ~/.bashrc
cd /mnt/data
ls
d ~
cd ~
vim ~/.bashrc
source ~/.bashrc
vim ~/.bashrc
source ~/.bashrc
hdfs
jps

cat ./pagerank_large_keyBy.py 
vim mod3.py
./run_one_job.sh ./mod3.py 200 yes
net stat -anp | grep LISTEN 
sudo apt-get install samba samba-common
net stat -anp | grep LISTEN 
net --help
netstat -anp | grep LISTEN 
jps
stop-all.sh
cd /mnt/data/
hadoop-3.1.2/sbin/stop-all.sh 
jps
ls
spark-2.4.4-bin-hadoop2.7/sbin/stop-all.sh 
jps
spark-2.4.4-bin-hadoop2.7/sbin/stop-history-server.sh 
jps
hostname -I
vim hadoop-3.1.2/etc/hadoop/core-site.xml 
vim hadoop-3.1.2/etc/hadoop/workers 
vim spark-2.4.4-bin-hadoop2.7/conf/slaves
vim hadoop-3.1.2/sbin/start-dfs.sh 
hadoop-3.1.2/sbin/start-dfs.sh 
jps
netstat -anp | grep LISTEN 
spark-2.4.4-bin-hadoop2.7/sbin/start-all.sh 
jps
spark-2.4.4-bin-hadoop2.7/sbin/start-history-server.sh 
jps
exit
cd /mnt/data/
ls
cd spark_logs/
ls
cd app-20190922184312-0000
vim app-20190922184312-0000
netstat -anp | grep LISTEN 
exit
cd /mnt/data/
ls
vim spark-2.4.4-bin-hadoop2.7/conf/spark-defaults.conf
exit
cd ~
vim pagerank_custome_p.py 
spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
rm -rf LeftRanks_Output/
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
exit
cd ~
ls
vim pagerank_custome_p.py 
python
ls
cd ~
jps
ifonfig
ifconfig
ls
vim pagerank_nopartition.py 
vim ~/.vimrc
source ~/.vimrc
vim ~/.vimrc
source ~/.vimrc
vim pagerank_nopartition.py 
ifconfig
hostname -i
ls
cp mod3.py pagerank_custome_p.py
vim pagerank_custome_p.py 
spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 
ls
which spark
which spark-submit
jps
vim pagerank_custome_p.py 
V
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
vim pagerank_custome_p.py 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
vim pagerank_custome_p.py 
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
rm -rf LeftRanks_Output/
/mnt/data/spark-2.4.4-bin-hadoop2.7/bin/spark-submit ~/pagerank_custome_p.py 200 yes
