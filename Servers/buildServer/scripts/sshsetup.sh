#!/bin/bash -eux

cd /home/vagrant
mkdir .ssh
wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'

sleep 10
pwd
cat authorized_keys
mv authorized_keys .ssh
ls -lrta .
chown vagrant:vagrant .ssh
sudo chmod 700 .ssh
sudo chown vagrant:vagrant .ssh/authorized_keys
sudo chmod 600 .ssh/authorized_keys
ls -lrta .

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
systemctl restart sshd.service

cat /etc/ssh/sshd_config

sudo sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/sysconfig/selinux
cat /etc/sysconfig/selinux
sudo bash -c "echo 'UseDNS no' >> /etc/ssh/sshd_config"
sudo systemctl stop firewalld
yum -y clean all
sudo rm -f /etc/udev/rules.d/70-persistent-net.rules

sudo sed -i '/^UUID/d' /etc/sysconfig/network-scripts/ifcfg-en*
sudo sed -i '/^HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-en*

tree /home/vagrant
sudo rm -f /var/log/wtmp /var/log/btmp
history -c

sleep 20