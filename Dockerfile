# Creates pseudo distributed hadoop 2.7.1
#
# docker build -t sequenceiq/hadoop .

FROM ubuntu
MAINTAINER sjayasinghs <sjayasinghs@gmail.com>

USER root

# install dev tools
RUN apt update; \
    apt install -y default-jdk; \
    apt install -y openssh-server; \
    apt install -y vim;

# Download the Hadoop package	
RUN wget http://www-eu.apache.org/dist/hadoop/common/hadoop-1.2.1/hadoop-1.2.1.tar.gz
RUN tar xvf hadoop-1.2.1.tar.gz
RUN mv hadoop-1.2.1 hadoop
RUN mv hadoop /usr/

# Adding the configuration file.
ADD core-site.xml /usr/hadoop/conf/
ADD hdfs-site.xml /usr/hadoop/conf/
ADD mapred-site.xml /usr/hadoop/conf/
ADD topology.sh /usr/hadoop/conf/
ADD topology.data /usr/hadoop/conf/

# Creating dedicated users
RUN addgroup hadoop
RUN useradd -m -G hadoop hduser
RUN chown -R hduser:hadoop /usr/hadoop

# Creating passwordless ssh
RUN su - hduser -c 'ssh-keygen -t rsa -f ~/.ssh/id_rsa -P "" && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys'

# Adding environment variables to hduser, so that hduser can access the hadoop commands and scripts.	
ENV HADOOP_PREFIX 	/usr/hadoop
RUN su - hduser -c  'echo -e "export JAVA_HOME=/usr/lib/jvm/default-java\nexport HADOOP_PREFIX=/usr/hadoop\nexport PATH=$PATH:/usr/hadoop/bin" >> $HOME/.bashrc'

#configure hadoop directories. 
RUN  mkdir -p /data/hadoop/tmp
RUN chown hduser:hadoop /data/hadoop/tmp && chmod 750 /data/hadoop/tmp

RUN su - hduser -c 'echo export JAVA_HOME="/usr/lib/jvm/default-java" >> /usr/hadoop/conf/hadoop-env.sh'

ADD ssh_config /home/hduser/.ssh/ 
RUN chown -R hduser /home/hduser/.ssh

ADD bootstrap.sh /home/hduser/bootstrap.sh	
ENTRYPOINT ["/home/hduser/bootstrap.sh"]
CMD ["-bash"]