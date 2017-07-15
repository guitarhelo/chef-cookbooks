#
# Cookbook Name:: ucmdb_win
# Recipe:: test
#
# Copyright 2014 HP
#
include_recipe "winsoft::7-zip"
share_uri  = node['ucmdb']['install']['share_uri']
iso_file   = node['ucmdb']['install']['iso_file']
setup_exe  = node['ucmdb']['install']['setup_exe']
dataflowprobe_exe = node['ucmdb']['install']['dataflowprobe_exe']
home_dir   = node['ucmdb']['install']['home_dir']
server_install_dir   = node['ucmdb']['install']['home_dir'] + "\\UCMDBServer"
dataflowprobe_install_dir   = node['ucmdb']['install']['home_dir'] + "\\DataFlowProbe"

hpcm_exe   =node['ucmdb']['install']['hpcm_exe']
hpcm_install_dir=node['ucmdb']['install']['home_dir']+"\\HPCM"

type       = node['ucmdb']['install']['type']

slick_path = node['ucmdb']['install']['ucmdb_slick_path']
db_host    = node['ucmdb']['db']['host']
db_type    = node['ucmdb']['db']['type']
db_port    = node['ucmdb']['db']['port']
db_name    = node['ucmdb']['db']['name']
dba_user   = node['ucmdb']['install']['dba_user']
dba_pass   = node['ucmdb']['install']['dba_pass']



drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "ucmdb"))
setup_exe    = extract_path + "\\" + setup_exe
dataflowprobe_exe   = extract_path + "\\" + dataflowprobe_exe
ucmdb_server_install_properties = extract_path + "\\server.properties"
ucmdb_server_install_properties_template = "server.properties.erb"

dataflowprobe_install_properties = extract_path + "\\dataflowprobe.properties"
dataflowprobe_install_properties_template = "dataflowprobe.properties.erb"


db_scripts_path =home_dir +"\\db"
ucmdb_db_user  = node['ucmdb']['db']['user']
ucmdb_db_pass  = node['ucmdb']['db']['pass']
dbuser_create_script_template = "createdbusr.sql.erb"
dbuser_create_script = db_scripts_path  + "\\createdbuser.sql"
dbuser_create_output = home_dir  + "\\dbuser_create_output.txt"
db_create_output= home_dir  + "\\db_create_output.txt"
db_init_output= home_dir  + "\\db_init_output.txt"
db_init_script=slick_path+"\\dbconfig.bat"


hpcm_exe   = extract_path + "\\" + hpcm_exe

hpcm_install_properties = extract_path + "\\hpcm.properties"
hpcm_install_properties_template = "hpcm.properties.erb"



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

directory db_scripts_path do
  action :create
  recursive true
end



mount drive_letter do
  action :mount
  device share_uri
end

windows_batch 'unzip iso' do
  code <<-EOH
  7z.exe x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos
  EOH
end
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
template dbuser_create_script do
  source dbuser_create_script_template
end

cmd = "#{setup_exe} -i silent -f #{ucmdb_server_install_properties}" 
execute "install ucmdb server" do
  command cmd
end


cmd = "#{dataflowprobe_exe} -i silent -f #{dataflowprobe_install_properties}"

execute "install dataflowprobe" do
  command cmd
end

db_create_cmd="#{db_init_script} create -d #{db_type} -o #{db_host} -p #{db_port} -u #{dba_user} -a #{dba_pass} -s #{db_name} >#{db_create_output}"

execute "create db" do 
	command db_create_cmd
end
execute "create db user" do
  command "sqlcmd -H #{db_host} -U #{dba_user} -P #{dba_pass} -i #{dbuser_create_script} -o #{dbuser_create_output}"
end

db_conf_create_cmd = "#{db_init_script} connect -d #{db_type} -o #{db_host} -p #{db_port} -u #{ucmdb_db_user} -a #{ucmdb_db_pass} -s #{db_name} >#{db_init_output}"
execute "db conf generate" do
 command db_conf_create_cmd
end

directory db_scripts_path do
  action :delete
  recursive true
end

service "UCMDB_Server" do
  action :start
end
sleep 360
service "UCMDB_Integration" do
  action :start
end
sleep 360


template hpcm_install_properties  do
  source hpcm_install_properties_template
   variables({
     :hpcm_install_dir => hpcm_install_dir
   })
end
cmd = "#{hpcm_exe} -i silent -f #{hpcm_install_properties}"

execute "install hp cm" do
  command cmd

end


directory extract_path do
  action :delete
  recursive true
end
mount drive_letter do
  device share_uri
  action :umount
end

