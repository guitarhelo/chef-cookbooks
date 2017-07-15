include_recipe "winsoft::7-zip"

share_uri  = node['hpoo9']['install']['share_uri']
iso_file   = node['hpoo9']['install']['iso_file']
setup_exe  = node['hpoo9']['install']['setup_exe']
studio_exe = node['hpoo9']['install']['studio_exe']
oo_pass    = node['hpoo9']['install']['admin_pass']
home_dir   = node['hpoo9']['install']['home_dir']
db_pass    = node['hpoo9']['db']['pass']

drive_letter = "T:"
extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "hpoo9"))
setup_exe    = extract_path + "\\" + setup_exe
studio_exe   = extract_path + "\\" + studio_exe
xml_input_studio = extract_path + "\\xmlinputstudio.xml"
xml_input_studio_template = "xmlinput_studio.xml.erb"
xml_input    = extract_path + "\\xmlinput.xml"
xml_input_template = "xmlinput.xml.erb"

sql_script_template = "createdbusr.sql.erb"
sql_script = extract_path + "\\createdbuser.sql"
sql_output = extract_path + "\\sql_output.txt"

directory home_dir do
  action :create
  recursive true
end

directory extract_path do
  action :create
  recursive true
end

template sql_script do
  source sql_script_template
end

execute "create db and user" do
  command "sqlcmd -i #{sql_script} -o #{sql_output}"
end

mount drive_letter do
  action :mount
  device share_uri
end

cmd = "7z x #{drive_letter}\\#{iso_file} -o#{extract_path} -aos"
execute "extract iso" do
  command cmd
end

template xml_input do
  source xml_input_template
end

template xml_input_studio do
  source xml_input_studio_template
end

cmd = "#{setup_exe} /VERYSILENT /SUPPRESSMSGBOXES /XMLINPUT=#{xml_input} /aaccountpwd=#{oo_pass} /dbpwd=#{db_pass} /LOG=#{home_dir}\\install.txt /DIR=#{home_dir}"

execute "install central+ras" do
  command cmd
end

env "ICONCLUDE_HOME" do
  value home_dir
end

cmd = "#{studio_exe} /VERYSILENT /SUPPRESSMSGBOXES /XMLINPUT=#{xml_input_studio} /TASKS=desktopicon /LOG=#{home_dir}\\install_studio.txt /DIR=#{home_dir}"

execute "install studio" do
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

