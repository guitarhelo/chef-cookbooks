#
# Cookbook Name:: ucmdb_win
# Recipe:: hpcm
#
# Copyright 2014 HP
#
include_recipe "winsoft::7-zip"
share_uri  = node['ucmdb']['install']['share_uri']
iso_file   =share_uri +"\\"+node['ucmdb']['install']['iso_file']
hpcm_exe   =node['ucmdb']['install']['hpcm_exe']
home_dir   = node['ucmdb']['install']['home_dir']
hpcm_install_dir=node['ucmdb']['install']['home_dir']+"\\HPCM"
type       = node['ucmdb']['install']['type']

#drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "hpcm"))

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
utils_archive iso_file do
  extract_to extract_path
end

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
#mount drive_letter do
#  device share_uri
#  action :umount
#end

