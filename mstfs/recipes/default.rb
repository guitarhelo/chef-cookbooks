#cookbook Name:: mstfs
# Recipe:: default
#
# Copyright 2014 HP
include_recipe "winsoft::7-zip"
iso_file   = node['mstfs']['install']['iso']
setup_exe  = node['mstfs']['install']['setup_exe']
home_dir   = node['mstfs']['install']['home_dir']
type       = node['mstfs']['install']['type']

extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "mstfs"))
setup_exe    = extract_path + "\\" + setup_exe

directory extract_path do
  action :create
  recursive true
end

utils_archive iso_file do
  extract_to extract_path
end

setup_cmd = "#{setup_exe} /quiet" 
execute "install TFS server" do
  command setup_cmd
end


#directory extract_path do
#  action :delete
# recursive true
#end
