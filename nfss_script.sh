  sudo -i
  yum install -y nfs-utils
  mkdir /srv/share
  chgrp nfsnobody /srv/share/
  chmod g+w /srv/share/
  ls -l  /srv
  echo '/srv/share 192.168.50.11/24(rw,sync)' >> /etc/exports
  exportfs -r
  systemctl start nfs-server
  systemctl enable nfs-server
  systemctl start firewalld
  firewall-cmd --permanent --add-service={mountd,nfs,rpc-bind}
  firewall-cmd --reload
  showmount -e
  exit
  