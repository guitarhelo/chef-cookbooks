#
# Cookbook Name:: sitescope_win
# Recipe:: default
#
# Copyright 2014 HP
#
include_recipe "winsoft::7-zip"

share_uri  = node['sitescope']['install']['share_uri']
iso_file   = node['sitescope']['install']['iso_file']
setup_exe  = node['sitescope']['install']['setup_exe']
sitescope_pass    = node['sitescope']['install']['admin_pass']
home_dir   = node['sitescope']['install']['home_dir']
type       = node['sitescope']['install']['type']

drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "sitescope"))
setup_exe    = extract_path + "\\" + setup_exe

db_scripts_path =home_dir +"\\dbscript"
sitescope_install_properties = extract_path + "\\Windows_Setup\\SiteScope\\ovinstallparams.ini"
sitescope_install_properties_template = "ovinstallparams.ini.erb"
sql_script_template = "createdbusr.sql.erb"
sql_script = db_scripts_path + "\\createdbuser.sql"
sql_output = db_scripts_path + "\\sql_output.txt"

directory home_dir do
  action :create
  recursive true
end
directory db_scripts_path do
  action :create
  recursive true
end

directory extract_path do
  action :create
  recursive true
end
 
mount drive_letter do
  action :mount
  device share_uri
end
cmd = "7z.exe x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos"
execute "extract iso" do
  command cmd
end
template sitescope_install_properties  do
  source sitescope_install_properties_template
end
cmd = "#{setup_exe} -i silent"

execute "install sitescope" do
  command cmd
end
template sql_script do
  source sql_script_template
end

execute "create db and user" do
  command "sqlcmd -i #{sql_script} -o #{sql_output}"
end

#directory extract_path do
#  action :delete
#  recursive true
#end
mount drive_letter do
  device share_uri
  action :umount
end
