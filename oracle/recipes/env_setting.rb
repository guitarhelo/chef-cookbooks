# Cookbook Name:: oracle
# Recipe:: env_setting
# enable NFS client mount and allow a remote script to login and run a command via sudo
# Copyright 2014 HP
yum_package "nfs-utils" do
  action :install
end
service "rpcbind" do
  action :start
end
bash "allow a remote script to login and run a command via sudo" do
  user "root"
  cwd "/etc"
  code <<-EOH
  chmod +w /etc/sudoers
  sed -i 's/Defaults requiretty/#Defaults requiretty/g' /etc/sudoers
  chmod -w /etc/sudoers
  EOH
end
