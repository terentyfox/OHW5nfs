sudo -i
yum install nfs-utils
systemctl start rpcbind
systemctl enable rpcbind

systemctl enable firewalld --now
systemctl status firewalld
echo "***************************fromitdraft***********"
#systemctl start rpcbind
#systemctl enable rpcbind

mount -t nfs 192.168.50.10:/srv/share /mnt

mount | grep mnt

umount 192.168.50.10:/srv/share /mnt
mount | grep mnt

echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0">> /etc/fstab
systemctl daemon-reload
systemctl restart remote-fs.target

mount | grep mnt

#echo "**********REBOOTING*************"
#reboot
