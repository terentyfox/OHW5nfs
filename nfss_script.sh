  #!/bin/bash
  
  sudo -i
  yum install -y nfs-utils
  
  echo "Preparing'n'starting nfs-sharing" 
  systemctl enable nfs-server
  systemctl start nfs-server
  systemctl enable firewalld
  systemctl start firewalld
  firewall-cmd --permanent --add-service={mountd,nfs,rpc-bind}
  firewall-cmd --reload
  
  echo 'Creating & exporting shared directories'
  mkdir /srv/share
  mkdir /srv/share/_upload_
 

  
  echo '/srv/share 192.168.50.11(rw,all_squash,sync,no_subtree_check)' >> /etc/exports
  echo '/srv/share/_upload_ 192.168.50.11(rw,all_squash,sync,no_subtree_check)' >> /etc/exports
  exportfs -r  
  
  chgrp -R nfsnobody /srv/share/
  chmod g+w /srv/share/_upload_
  
  showmount -e
  
  touch /srv/share/test0
  echo 'true working nfs' > /srv/share/test0
  
  exit
  
