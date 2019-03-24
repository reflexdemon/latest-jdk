#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade

# Get "add-apt-repository" Command
sudo apt-get install -y software-properties-common

sudo apt-get update

#Install Build essentials
sudo apt-get install -y build-essential git vim curl wget unzip tar
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


#Install JAVA

# # See https://stackoverflow.com/questions/10268583/downloading-java-jdk-on-linux-via-wget-is-shown-license-page-instead
# echo 'Installing JAVA 1.9'
# mkdir /opt/java && cd /opt/java
# # curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz > jdk-8u25-linux-x64.tar.gz
# #wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/jdk-8u131-linux-x64.tar.gz
# wget  -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz

# tar -xf jdk-9.0.4_linux-x64_bin.tar.gz
# ln -sf /opt/java/jdk-9 /opt/java/current
# sudo su vagrant
# echo 'export JAVA_HOME=/opt/java/current' >> /home/vagrant/.bashrc
# echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/vagrant/.bashrc
# sudo su root

# To install latest JDK see https://github.com/sormuras/bach

JDK_VERSION=12
JDK_TARGET=/opt/jdk

MONGO_VERSION=3.2.1
MONGO_TARGET=/opt/mongo

GRADLE_TARGET=/opt/gradle

if [ ! -d "$JDK_TARGET" ]; then
	JAVA_HOME=$(/project/home/install-jdk.sh --silent --emit-java-home --target $JDK_TARGET -f $JDK_VERSION)
	echo 'export JAVA_HOME='${JAVA_HOME} >> /home/vagrant/.bashrc
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/vagrant/.bashrc
else
	echo 'Java already installed'
	java -version
if

#Install Mongo
if [ ! -d "$MONGO_TARGET" ]; then
  	# Control will enter here if $DIRECTORY doesn't exist.
  	mkdir $MONGO_TARGET
	cd $MONGO_TARGET
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-$MONGO_VERSION.tgz
	tar -xf mongodb-linux-x86_64-ubuntu1404-$MONGO_VERSION.tgz  
	ln -sf mongodb-linux-x86_64-ubuntu1404-$MONGO_VERSION current  
	mkdir $MONGO_TARGET/data  
	$MONGO_TARGET/current/bin/mongod --dbpath $MONGO_TARGET/data/ --fork --logpath /var/log/mongod.log
else
	echo 'Mongo db already installed'
fi



#Install Gradel
if [ ! -d "$GRADLE_TARGET" ]; then
	wget https://services.gradle.org/distributions/gradle-5.3-bin.zip
	unzip -d /opt/gradle gradle-5.3-bin.zip
	echo 'export PATH=/opt/gradle/gradle-4.0.1/bin:$PATH' >> /home/vagrant/.bashrc
	echo 'export GRADLE_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED"' >> /home/vagrant/.bashrc
else
	echo 'Gradel already installed'
fi


# echo 'cd /project/home' >> /home/vagrant/.bashrc

source ~/.bashrc

