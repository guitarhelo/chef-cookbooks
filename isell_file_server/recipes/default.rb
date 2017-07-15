#
# Cookbook Name:: isell_file_server
# Recipe:: default
#
# Copyright 2014 HP
#
include_recipe "winsoft::7-zip"
share_uri  = node['isell_file_server']['install']['share_uri']
zip_file   = "ebclmfssales01_local-"+node['isell_file_server']['install']['version']+"-local.zip"
home_dir   = node['isell_file_server']['install']['home_dir']
setup_bat  = node['isell_file_server']['install']['bin_dir']+"\\"+node['isell_file_server']['install']['setup_bat']
start_bat  = node['isell_file_server']['install']['bin_dir']+"\\"+node['isell_file_server']['install']['start_bat']

drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "file_server"))



directory home_dir do
  action :create
  recursive true
end

directory extract_path do
  action :create
  recursive true
end
 
utils_archive zip_file do
  extract_to extract_path
end

install_cmd = "#{setup_bat}"

execute "install isell file server" do
  command install_cmd
end
start_cmd= "#{start_bat}"
execute "start isell file server" do
  command start_cmd
end

directory extract_path do
  action :delete
  recursive true
end

