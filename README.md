Creating Hadoop 1.2.1 cluster on Ubuntu OS. 
-------------------------------------------

Building the image :
--------------------

docker image build -t [Image name] .

eg:
docker image build -t hadoop1.2.1-cluster .


Running Hadoop Servers :
-----------------------

Server Name : hc-cluster-nn
Server Role : Master - Namenode

docker container run -d -it --name hc-cluster-nn --network hc-cluster --hostname hc-cluster-nn -p 50070:50070 hadoop1.2.1-cluster 

Server Name : hc-cluster-jt
Server Role : Master - JobTracker, SecondaryNamenode

docker container run -d -it --name hc-cluster-jt --network hc-cluster --hostname hc-cluster-jt -p 50090:50090 -p 50030:50030 hadoop1.2.1-cluster 

Server Name : hc-cluster-dn1 - hc-cluster-dn5
Server Role : Slave - Datanode, TaskTracker

docker container run -d -it --name hc-cluster-dn1 --network hc-cluster --hostname hc-cluster-dn1 -p 10060:50060 -p 10075:50075 hadoop1.2.1-cluster 

docker container run -d -it --name hc-cluster-dn2 --network hc-cluster --hostname hc-cluster-dn2 -p 20060:50060 -p 20075:50075 hadoop1.2.1-cluster 

docker container run -d -it --name hc-cluster-dn3 --network hc-cluster --hostname hc-cluster-dn3 -p 30060:50060 -p 30075:50075 hadoop1.2.1-cluster 

docker container run -d -it --name hc-cluster-dn4 --network hc-cluster --hostname hc-cluster-dn4 -p 40060:50060 -p 40075:50075 hadoop1.2.1-cluster 

docker container run -d -it --name hc-cluster-dn5 --network hc-cluster --hostname hc-cluster-dn5 -p 50060:50060 -p 50075:50075 hadoop1.2.1-cluster 
