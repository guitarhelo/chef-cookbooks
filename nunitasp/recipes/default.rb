#
# Cookbook Name:: nunitasp
# Recipe:: default
#
# Copyright 2014,HP 
#
# All rights reserved
home_dir   = node['nunitasp']['install']['home_dir']

#directory home_dir do
#  action :create
#  recursive true
#end
# Download the selected PHPMyAdmin archive	
#remote_file "file:///#{home_dir}/NUnitAsp-#{node['nunitasp']['version']}.zip" do

install_url  = node['nunitasp']['url']
checksum     = node['nunitasp']['checksum']


local_zip_path = cached_file(install_url, checksum)


cmd = "7z.exe x #{local_zip_path} -o#{home_dir} -aos"
execute "extract zip" do
  command cmd
end
#file "file:///#{home_dir}/NUnitAsp-#{node['nunitasp']['version']}.zip" do
#action :delete
#end
