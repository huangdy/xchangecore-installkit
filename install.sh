#!/bin/sh

echo Install the xChagneCore environment >> install.log
echo There are couple tools needed to be installed if they have not installed yet, such as Java, rpl, unzip, curl, mysql-server >> install.log
echo The way to install are: >> install.log
echo 	- sudo apt-get install rpl >> install.log
echo 	- sudo apt-get install unzip >> install.log
echo 	- sudo apt-get install curl >> install.log
echo 	- sudo apt-get install mysql-server >> install.log

echo Install the xchangecore and opendj-connector >> install.log
cd xchangecore && ./install.sh && cd -

echo Install the OpenDJ >> install.log
cd opendj && ./install.sh && cd -

echo Install the Tomcat >> install.log
cd tomcat && ./install.sh && cd -

echo Install the OpenFire >> install.log
cd openfire && ./install.sh && cd -