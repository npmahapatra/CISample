#!/bin/bash -eux

cd /home/vagrant

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
systemctl restart sshd.service

cat /etc/ssh/sshd_config

sudo sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/sysconfig/selinux
cat /etc/sysconfig/selinux
sudo bash -c "echo 'UseDNS no' >> /etc/ssh/sshd_config"
sudo systemctl stop firewalld
yum -y clean all
sudo rm -f /etc/udev/rules.d/70-persistent-net.rules

#sudo sed -i '/^UUID/d' /etc/sysconfig/network-scripts/ifcfg-en*
#sudo sed -i '/^HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-en*

sudo rm -f /var/log/wtmp /var/log/btmp
history -c

sleep 5