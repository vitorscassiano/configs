#!/bin/sh

add-apt-repository ppa:webupd8team/java &&
apt-get update &&
apt-get install oracle-java8-installer &&
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections &&
update-java-alternatives -s java-8-oracle &&

wget -O /tmp/intellij.tar.gz http://download.jetbrains.com/idea/ideaIC-12.0.4.tar.gz &&
tar xfz /tmp/intellij.tar.gz &&
cd idea-IC-123.169/bin &&
./idea.sh
