sudo -i
touch ~/starthist
yum install -y nfs-utils
echo "nfs utils installed" >> starthist
systemctl enable firewalld --now
system status firewalld

firewall-cmd --add-service="rpc-bind" --permanent
firewall-cmd --reload

firewall-cmd --add-service="nfs3" --add-service="mountd" --permanent
firewall-cmd --reload

systemctl enable nfs --now
ss -tnplu

mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

cat <<EOF> /etc/exports
/srv/share 192.168.50.11/24(rw,sync,root_squash)
EOF
exportfs -r
exportfs -s
echo "******MOUNTPOINTS CREATED ON THIS SERVER********"
showmount -e 192.168.50.10
exit

