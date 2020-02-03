#!/bin/bash -eux

#Create jenkins root directory
cd /
sudo mkdir jenkins
sudo chmod 777 jenkins
sudo mkdir vagrant
sudo chmod 777 vagrant

# Install Python, GIT, Java, Maven, wget
sudo yum -y install python3 python3-pip git java-11-openjdk-devel maven wget

#Install tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp
wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz

tar -xf apache-tomcat-9.0.30.tar.gz


sudo mv apache-tomcat-9.0.30 /opt/tomcat/
sudo ln -s /opt/tomcat/apache-tomcat-9.0.30 /opt/tomcat/latest
sudo chown -R tomcat: /opt/tomcat
chmod -R 777 /opt/tomcat
sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

sudo echo "[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/jre"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target">/etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl enable tomcat
systemctl enable firewalld
systemctl start firewalld
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

#update the tomcat file with username
sed -i '/<\/tomcat\-users\>/d' /opt/tomcat/latest/conf/tomcat-users.xml
sudo echo "<!--
    Comments
-->
   <role rolename=\"manager-gui\"/>
   <role rolename=\"admin-gui\"/>
   <role rolename=\"manager-script\"/>
   <user username=\"admin\" password=\"admin_password\" roles=\"admin-gui,manager-gui,manager-script\"/>
</tomcat-users>">>/opt/tomcat/latest/conf/tomcat-users.xml

#enable access from my local machine
sudo sed -i '/RemoteAddrValve/d' /opt/tomcat/latest/webapps/manager/META-INF/context.xml
sudo sed -i '/0:0:0:0:0:0:0:1/d' /opt/tomcat/latest/webapps/manager/META-INF/context.xml
sudo cat /opt/tomcat/latest/webapps/manager/META-INF/context.xml

sudo sed -i '/RemoteAddrValve/d' /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
sudo sed -i '/0:0:0:0:0:0:0:1/d' /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
sudo cat /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml

sudo sed -i '0,/redirectPort\=\"8443\"/ s/redirectPort\=\"8443\"/redirectPort=\"8443\" useIPVHosts\=\"true\" address\=\"0\.0\.0\.0\" resolveHosts\=\"true\"/' /opt/tomcat/latest/conf/server.xml
cat /opt/tomcat/latest/conf/server.xml