#!/bin/bash
#install open jdk 11, curl, wget
sudo apt update
sudo apt install -y openjdk-11-jdk curl wget
#Here we will download WildFly latest veresion
WILDFLY_RELEASE=$(curl -s https://api.github.com/repos/wildfly/wildfly/releases/latest%7Cgrep tag_name|cut -d '"' -f 4)
wget https://github.com/wildfly/wildfly/releases/download/${WILDFLY_RELEASE}/wildfly-${WILDFLY_RELEASE}.tar.gz
# Extracting file
tar xvf wildfly-${WILDFLY_RELEASE}.tar.gz
#Move resulting folder to /opt/wildfly
sudo mv wildfly-${WILDFLY_RELEASE} /opt/wildfly
#Configure Systemd for WildFly
# create a system user and group that will run WildFly service.
sudo groupadd --system wildfly
sudo useradd -s /sbin/nologin --system -d /opt/wildfly  -g wildfly wildfly
#Create WildFly configurations directory.
sudo mkdir /etc/wildfly
#Copy WildFly systemd service configuration file and start scripts templates from the /opt/wildfly/docs/contrib/scripts/systemd/ directory.
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo chmod +x /opt/wildfly/bin/launch.sh
#Set /opt/wildfly permissions.
sudo chown -R wildfly:wildfly /opt/wildfly
#Reload systemd service.
sudo systemctl daemon-reload
#Start and enable WildFly service:
sudo systemctl start wildfly
sudo systemctl enable wildfly
#WildFly Application Server status
sudo systemctl status wildfly
#Service should bind to port 8080.
ss -tunelp | grep 8080
#Add WildFly Users
sudo /opt/wildfly/bin/add-user.sh
#Accessing WildFly Admin Console. add /opt/wildfly/bin/ to your $PATH.
#cat >> ~/.bashrc <<EOF
#3export WildFly_BIN="/opt/wildfly/bin/"
#export PATH=\$PATH:\$WildFly_BIN
#EOF
#Source the bashrc file.
#source ~/.bashrc
#
#jboss-cli.sh --connect
#exit