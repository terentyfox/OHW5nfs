#!/bin/bash
  
sudo -i

yum install -y nfs-utils

echo 'Creating systemd units for mounting two nfs shares with different rights'
cat <<EOF | tee /etc/systemd/system/mnt-share.mount
[Unit]
Description = Mount read-only nfs share
Requires = network-online.service
After = network-online.service

[Mount]
What = 192.168.50.10:/srv/share
Where = /mnt/share
Type = nfs
Options = defaults

[Install]
WantedBy = multi-user.target
EOF

cat <<EOF | tee /etc/systemd/system/mnt-share-_upload_.mount
[Unit]
Description = Mount read-write nfs share
Requires = network-online.service
After = network-online.service

[Mount]
What = 192.168.50.10:/srv/share/_upload_
Where = /mnt/share/_upload_
Type = nfs
Options = defaults

[Install]
WantedBy = multi-user.target
EOF

systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-service={mountd,nfs,rpc-bind}
systemctl enable mnt-share.mount
systemctl enable mnt-share-_upload_.mount

usermod -a -G nfsnobody vagrant

cat <<EOF | tee /home/vagrant/testscript.sh
#!/bin/bash
cat /mnt/share/test0
cp /mnt/share/test0 /mnt/share/_upload_/test1
cat /mnt/share/_upload_/test1
cp /mnt/share/_upload_/test1 /mnt/share/test2
cat /mnt/share/test2
EOF

chmod u+x /home/vagrant/testscript.sh

echo 'Rebooting'
reboot
