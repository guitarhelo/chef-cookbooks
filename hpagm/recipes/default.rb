#
# Cookbook Name:: hpagm
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved 

#

install_temp_folder=node[:agm][:install][:home_dir]+"/agm_install"
qcconfigfile_properties_template = "qcConfigFile.properties.erb"
qcconfigfile_properties = node[:agm][:install][:home_dir]  + "/conf/qcConfigFile.properties"

directory "#{install_temp_folder}" do
 action :create
 recursive true
end
directory "/tmp/hpagm_install" do
  action :create
  recursive true
end
mount "/tmp/hpagm_install" do
  device "#{node[:agm][:install][:share_uri]}"
  fstype "nfs"
  options "rw"
end
bash 'allow and add iptables rules for HP AGM' do
code <<-EOH
  sed -i "/-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT/a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT" /etc/sysconfig/iptables
  service iptables restart
EOH
end


bash 'install HP AGM' do
    cwd "/tmp/hpagm_install"
    code <<-EOH
     tar zxpvf #{node[:agm][:install][:install_file]} -C #{install_temp_folder} 
     cd #{install_temp_folder}
     rpm --import #{node[:agm][:install][:setup_keyfile]}
     rpm -ivh #{node[:agm][:install][:setup_exe]}
    EOH
end
template qcconfigfile_properties do
  source qcconfigfile_properties_template
end
bash 'Run config for HP AGM' do
 cwd "#{node[:agm][:install][:home_dir]}"
  code <<-EOH
   ./run_config.sh -nonInteractive
  EOH
end
 
service "HPALM" do
  action :start
end


mount "/tmp/hpagm_install" do
  device "#{node['agm']['install']['share_uri']}"
  action :umount
end
directory "/tmp/hpagm_install" do
  action :delete
  recursive true
end
directory "#{install_temp_folder}" do
  action :delete
  recursive true
end

