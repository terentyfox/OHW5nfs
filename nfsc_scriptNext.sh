sudo -i
yum install -y nfs-utils
mkdir /mnt/nfsshare
showmount -e 192.168.50.10
systemctl start nfs
echo '++++++++++++++++++++++NFS started'
systemctl enable nfs
echo '----------------------NFS enabled'
#echo '192.168.50.10:/srv/share /mnt/nfsshare nfs vers=3 0 0' >> /etc/fstab
echo '192.168.50.10:/srv/share /mnt/nfsshare nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0' >> /etc/fstab
echo '!!!!!!!!!!!!!!!!!!!!!!fstab modified' 
mount -a
echo '**********************share mounted here:'
mount | grep /mnt
exit

#vi192.168.50.10:/srv/share /mnt/nfsshare nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0

