#
# Cookbook Name:: ucmdb_win
# Recipe:: default
#
# Copyright 2014 HP
#
include_recipe "winsoft::7-zip"
share_uri  = node['ucmdb']['install']['share_uri']
iso_file   = share_uri+"\\"+node['ucmdb']['install']['iso_file']
setup_exe  = node['ucmdb']['install']['setup_exe']
dataflowprobe_exe = node['ucmdb']['install']['dataflowprobe_exe']
home_dir   = node['ucmdb']['install']['home_dir']
server_install_dir   = node['ucmdb']['install']['home_dir'] + "\\UCMDBServer"
dataflowprobe_install_dir   = node['ucmdb']['install']['home_dir'] + "\\DataFlowProbe"
type       = node['ucmdb']['install']['type']

#drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "ucmdb"))
setup_exe    = extract_path + "\\" + setup_exe
dataflowprobe_exe   = extract_path + "\\" + dataflowprobe_exe
ucmdb_server_install_properties = extract_path + "\\server.properties"
ucmdb_server_install_properties_template = "server.properties.erb"

dataflowprobe_install_properties = extract_path + "\\dataflowprobe.properties"
dataflowprobe_install_properties_template = "dataflowprobe.properties.erb"


# Ensure the installation ISO url has been set by the user
if share_uri.nil?
  raise "'ucmdb install share url' attribute must be set before running this cookbook"
end

directory home_dir do
  action :create
  recursive true
end

directory extract_path do
  action :create
  recursive true
end
utils_archive iso_file do
  extract_to extract_path
end
#mount drive_letter do
#  action :mount
#  device share_uri
#end

#windows_batch 'unzip iso' do
#  code <<-EOH
#  7z.exe x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos
#  EOH
#end
#cmd = "7z.exe x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos"
#execute "extract iso" do
#  command cmd
#end
template ucmdb_server_install_properties  do
  source ucmdb_server_install_properties_template
  variables({
     :server_install_dir => server_install_dir
   })
end
template dataflowprobe_install_properties  do
  source dataflowprobe_install_properties_template
   variables({
     :dataflowprobe_install_dir => dataflowprobe_install_dir,
     :hostname => node['hostname']
   })

end


cmd = "#{setup_exe} -i silent -f #{ucmdb_server_install_properties}" 
execute "install ucmdb server" do
  command cmd
end


cmd = "#{dataflowprobe_exe} -i silent -f #{dataflowprobe_install_properties}"

execute "install dataflowprobe" do
  command cmd
end

directory extract_path do
  action :delete
  recursive true
end
#mount drive_letter do
#  device share_uri
#  action :umount
#end
