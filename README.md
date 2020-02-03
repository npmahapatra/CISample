# CISample by Nrusinha

This is a CI CD sample of a sample web application using Jenkins pipeline 

The architecture constitutes of 3 parts :
1. Source code at Github (https://github.com/npmahapatra/CISample)
1. Jenkins hosted on local system (http://127.0.0.1:8080/) - installed using chocolatey
2. Build Server (Jenkins node) created as a VM using Packer/vagrant from Centos7 ISO (http://192.168.56.1:8091/)
3. Deployment Server (Centos 7) created as a VM using vagrant from Centos 7 vagrant box (http://192.168.56.1:8061/)

Additional tools configured on Build and Deployment servers :
Tomcat 9
GIT
python
Java
Maven

How to access application ?
http://192.168.56.1:8091/mytestapp/ (in build server during integration Testing)
http://192.168.56.1:8061/mytestapp/ (in Deployment server)

Jenkins pipeline - http://localhost:8080/job/CICD-Craft-Java/
Github Webhook using https://my.webhookrelay.com/ (since jenkins IP is not public, localhost is not supported by github) - https://my.webhookrelay.com/v1/webhooks/d342cecf-38aa-4d77-a268-e656b74115d3
GIThub API token - nmapi - 501e25b7a87c3742c2a4c14800eac3af367c92f4


Download links :
https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box
