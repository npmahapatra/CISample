	#!/bin/bash -eux

	sudo export PATH=/usr/bin/:/bin/:/usr/local/bin/:$PATH

    sudo systemctl start tomcat
    sudo systemctl status tomcat

	vagrant_ip=$(ip address show enp0s8 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//' | tr -d '\n')
    echo "--------------------------------------------------"
    echo "Your buildserver vagrant instance is running at: $vagrant_ip"