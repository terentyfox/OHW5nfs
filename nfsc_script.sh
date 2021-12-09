yum install -y nfs-utils
mkdir /mnt/nfsshare
showmount -e 192.168.50.10
systemctl start nfs
systemctl enable nfs
echo '192.168.50.10:/srv/share /mnt/nfsshare nfs vers=3,_netdev 0 0' >> /etc/fstab
mount -a
mount | grep /mnt
