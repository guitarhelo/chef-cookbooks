include_recipe "winsoft::sysinternals"

service_name = node['sql_server']['instance_name']
mnt_drive    = node['sql_server']['mnt_drive']
iso_file     = node['sql_server']['iso_file']
sys_user     = node['sql_server']['sys_user']
sys_pass     = node['sql_server']['sys_pass']
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "mssql"))

if service_name == 'SQLEXPRESS'
  service_name = "MSSQL" + service_name
end

mount mnt_drive do
  action :mount
  device node['sql_server']['share_path']
end
  
cmd = "7z x #{mnt_drive}\\#{iso_file} -o#{extract_path} -aos"
execute "extract iso" do
  command cmd
end

config_file_path = extract_path + "\\" + "ConfigurationFile.ini"
setup_exe        = extract_path + "\\" + node['sql_server']['setup_exe'] 
cmd              = setup_exe + " /q /ConfigurationFile=" + config_file_path

template config_file_path do
  source "ConfigurationFile.ini.erb"
end

bat_file   = extract_path + "\\" + "install.bat"

template bat_file do
  source "install.bat.erb"
  variables({:cmd => cmd})
end

execute "install" do
  command %Q!psexec.exe -u #{sys_user} -p #{sys_pass} /accepteula "#{bat_file}" 1> C:\\output.msg 2>&1!
end

service service_name do
  action :nothing
end

# set the static tcp port
static_tcp_reg_key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\\' + node['sql_server']['reg_version'] +
  node['sql_server']['instance_name'] + '\MSSQLServer\SuperSocketNetLib\Tcp\IPAll'

registry_key static_tcp_reg_key do
  recursive true
  values [{ :name => 'TcpPort', :type => :string, :data => node['sql_server']['port'].to_s },
    { :name => 'TcpDynamicPorts', :type => :string, :data => '' }]
  notifies :restart, "service[#{service_name}]", :immediately
end

include_recipe 'sql_server::client'
