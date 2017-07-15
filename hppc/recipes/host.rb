include_recipe "winsoft::7-zip"
share_uri  = node['pc']['install']['share_uri']
iso_file   = node['pc']['install']['iso_file']
pcserver_setup_exe  = node['pc']['install']['pcserver_setup_exe']
pchost_setup_exe    = node['pc']['install']['pchost_setup_exe']

home_dir   = node['pc']['install']['home_dir']


drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "PC"))
dotnet_setup = extract_path+ "\\Setup\\Common\\dotnet40\\dotnetfx40.exe"
mdca_setup   = extract_path+ "\\Setup\\En\\prerequisites\\mdac28\\mdac28.exe"
msi31_setup  = extract_path+ "\\Setup\\Common\\msi31\\WindowsInstaller-KB893803-v2-x86.exe"
msxml6_setup = extract_path+ "\\Setup\\Common\\msxml6\\msxml6.msi"
vc2005sp1_mfc_security_update_x86_setup= extract_path+ "\\Setup\\Common\\vc2005sp1_mfc_security_update_x86\\vcredist_x86.exe"
vc2005sp1_mfc_security_update_x64_setup= extract_path+ "\\Setup\\Common\\vc2005sp1_mfc_security_update_x64\\vcredist_x64.exe"
vc2008sp1_mfc_security_update_x86_setup= extract_path+ "\\Setup\\Common\\vc2008sp1_mfc_security_update_x86\\vcredist_x86.exe"
vc2008sp1_mfc_security_update_x64_setup= extract_path+ "\\Setup\\Common\\vc2008sp1_mfc_security_update_x64\\vcredist_x64.exe"
vc2010sp1_mfc_security_update_x86_setup= extract_path+ "\\Setup\\Common\\vc2010sp1_mfc_security_update_x86\\vcredist_x86.exe"
vc2012_redist_x86_setup =  extract_path+ "\\Setup\\Common\\vc2012_redist_x86\\vcredist_x86.exe"
vc2012_redist_x64_setup =  extract_path+ "\\Setup\\Common\\vc2012_redist_x64\\vcredist_x64.exe"
wse20sp3_setup          =  extract_path+ "\\Setup\\Common\\wse20sp3\\MicrosoftWSE2.0SP3Runtime.msi"
wse30_setup             =  extract_path+ "\\Setup\\Common\\wse30\\MicrosoftWSE3.0Runtime.msi"
pchost_setup_exe        =  extract_path+  "\\Setup\\Install\\Host\\PCHost_64Bit.msi"

directory home_dir do
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
windows_batch 'Performance Center Prerequisites package install' do
  code <<-EOH
  #{dotnet_setup} /q /norestart
  #{mdca_setup}  /q:A/C:"setup /QNT"
  #{msi31_setup} /quiet
  msiexec /log c:\msxml.log /quiet /I #{msxml6_setup}
  #{vc2005sp1_mfc_security_update_x86_setup} /q
  #{vc2005sp1_mfc_security_update_x64_setup} /q
  #{vc2008sp1_mfc_security_update_x86_setup} /q
  #{vc2008sp1_mfc_security_update_x64_setup} /q
  #{vc2010sp1_mfc_security_update_x86_setup} /q
  #{vc2012_redist_x86_setup} /q
  #{vc2012_redist_x64_setup} /q
  msiexec /log c:\WSE2.log /quiet /I  #{wse20sp3_setup}  ALLUSERS=1
  msiexec /log c:\WSE3.log /quiet /I  #{wse30_setup}     ALLUSERS=1
  EOH
end

registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" do
  values [{
    :name => "EnableLUA",
    :type => :dword,
    :data => 1
  }]
  action :delete
end
registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" do
  values [{
    :name => "EnableLUA",
    :type => :dword,
    :data => 0
  }]
  action :create
end

pc_host_setup_cmd = "msiexec /i #{pchost_setup_exe} /qnb"

execute "install Performance Center Host" do
  command pc_host_setup_cmd
end


#directory extract_path do
#  action :delete
#  recursive true
#end
mount drive_letter do
  device share_uri
  action :umount
end




