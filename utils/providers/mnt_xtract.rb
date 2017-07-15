include Utils

action :create do
  drive_letter = get_drive_letter + ":"
  file_name = ::File.basename(new_resource.name)
  uri = ::File.dirname(new_resource.name)

  if new_resource.extract_to.include? ":\\\\"
    extract_to = new_resource.extract_to
  else
    extract_to = Chef::Config['file_cache_path'] + "\\" + new_resource.extract_to
  end

  log "Extracting file: '#{new_resource.name}' to '#{extract_to}'"

  directory extract_to do
    action :create
    recursive true
  end

  mount drive_letter do
    action :mount
    device uri
  end

  cmd = "7z x #{drive_letter}\\#{file_name} -o#{extract_to} -aos"
  execute "extract" do
    command cmd
  end

  mount drive_letter do
    device uri
    action :umount
  end
end

