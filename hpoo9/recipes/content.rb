include_recipe "winsoft::7-zip"

iso_file  = node['hpoo9']['cp']['iso_file']

if node['hpoo9']['install']['type'] == "default"
  share_uri = node['hpoo9']['install']['share_uri']
  java      = node['hpoo9']['install']['home_dir'] + "\\jre1.6\\bin\\java"
  cUser     = "admin"
  cPass     = node['hpoo9']['install']['admin_pass']
  cURL      = "https://" + node['hpoo9']['central']['host'] + ":" + node['hpoo9']['central']['https_port']
  rURL      = "https://localhost:9004"
  home_dir  = node['hpoo9']['install']['home_dir']
else  
  share_uri = node['hpoo9']['cp']['share_uri']
  java      = node['hpoo9']['cp']['java']
  cUser     = node['hpoo9']['cp']['cUser']
  cPass     = node['hpoo9']['cp']['cUser']
  cURL      = node['hpoo9']['cp']['cURL']
  rURL      = node['hpoo9']['cp']['rURL']
  home_dir  = node['hpoo9']['cp']['home_dir']
end

extract_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "hpoo9cp"))
drive_letter = "S:"

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

ruby_block "find executable" do
  block do
    Dir.entries(extract_path).each do|jar|
      if jar.end_with?('jar')
        execute = Chef::Resource::Execute.new("install cp", run_context)
        execute.cwd extract_path
        execute.command "#{java} -jar #{jar} -centralURL #{cURL} -centralUsername #{cUser} -centralPassword #{cPass} -ras #{rURL} -home #{home_dir}"
        execute.run_action :run
      end
    end
  end
  action :run
end
