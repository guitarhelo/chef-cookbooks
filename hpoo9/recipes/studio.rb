share_uri    = node['hpoo9']['install']['share_uri']
iso_file     = node['hpoo9']['install']['iso_file']
studio_exe   = node['hpoo9']['install']['studio_exe']
home_dir     = node['hpoo9']['install']['home_dir']

extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "hpoo9"))
drive_letter = "T:"
xml_input_studio = extract_path + "\\xmlinputstudio.xml"
xml_input_studio_template = "xmlinput_studio.xml.erb"

env "ICONCLUDE_HOME" do
  value home_dir 
end

mount drive_letter do
  action :mount
  device share_uri
end

cmd = "7z e #{drive_letter}\\#{iso_file} #{studio_exe} -o#{extract_path} -aos"

execute "extract exe" do
  command cmd
end

template xml_input_studio do
  source xml_input_studio_template
end

studio_exe = File.basename(studio_exe)
cmd = "#{studio_exe} /VERYSILENT /SUPPRESSMSGBOXES /XMLINPUT=#{xml_input_studio} /TASKS=desktopicon /LOG=#{home_dir}\\install_studio.txt /DIR=#{home_dir}"

execute "install studio" do
  cwd extract_path
  command cmd
end
