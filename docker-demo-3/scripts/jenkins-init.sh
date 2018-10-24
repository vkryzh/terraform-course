#!/bin/bash

# volume setup
vgchange -ay

DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi
mkdir -p /var/lib/jenkins
echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/jenkins

#install Java 8
apt-get install -y python-software-properties debconf-utils
add-apt-repository ppa:webupd8team/java
apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
apt-get install -y oracle-java8-installer

# install jenkins and docker
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
apt-get update
apt-get install -y jenkins unzip docker.io

# enable docker and add perms
usermod -G docker jenkins
systemctl enable docker
service docker start
service jenkins restart

# install pip
wget -q https://bootstrap.pypa.io/get-pip.py
python get-pip.py
python3 get-pip.py
rm -f get-pip.py
# install awscli
pip install awscli

# install terraform
wget -q https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
&& unzip -o terraform_0.11.7_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_0.11.7_linux_amd64.zip

# clean up
apt-get clean
rm terraform_0.11.7_linux_amd64.zip
