include_recipe "winsoft::7-zip"

iso_file  = node['hpoo9']['patch']['iso_file']
version   = iso_file.sub(".zip","").sub("OOPATCH","")
bat_file  = "Upgrade_#{version}\\install_9_0x.bat"

if node['hpoo9']['install']['type'] == "default"
  share_uri = node['hpoo9']['install']['share_uri']
  home_dir  = node['hpoo9']['install']['home_dir']
else
  share_uri = node['hpoo9']['patch']['share_uri']
  home_dir  = node['hpoo9']['patch']['home_dir']
end

services = ['RSCentral', 'RSJRAS', 'RSScheduler']
def manage_service(srv_list, my_action)
  srv_list.each do |name|
    service name do
      action my_action
      timeout 120
    end
  end
end

extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "hpoo9patch"))
bat_file     = extract_path + "\\" + bat_file
drive_letter = "T:"

ENV['ICONCLUDE_HOME'] = home_dir 
ENV['JAVA_HOME'] = "#{home_dir}\\jre1.6"

directory extract_path do
  action :create
  recursive true
end

mount drive_letter do
  action :mount
  device share_uri
end

cmd = "7z x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos"
execute "extract iso" do
  command cmd
end

manage_service(services, "stop")

cmd = File.basename(bat_file) + " 1> #{home_dir}\\install_patch.txt 2>&1"
execute "install" do
  cwd File.dirname(bat_file)
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

services -= ['RSScheduler']
manage_service(services, "start")
