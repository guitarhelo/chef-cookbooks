mount "/tmp/install" do
  device "10.10.0.2:/srv/software/Oracle/sql_11g"
  fstype "nfs"
  options "rw"
end
yum_package 'unzip'
directory "/tmp/pan" do
  action :create
  recursive true
end
bash "copy oracle install img and unzip" do
  user "root"
  cwd "/tmp/install"
  code <<-EOH
  cp /tmp/install/linux.x64_11gR2_database_1of2.zip  /tmp/pan
  cp /tmp/install/linux.x64_11gR2_database_2of2.zip  /tmp/pan
  cd /tmp/pan
  unzip -o linux.x64_11gR2_database_1of2.zip
  unzip -o linux.x64_11gR2_database_1of2.zip
  EOH
end

node[:oracle][:rdbms][:install_files].each do |zip_file|
  execute "unzip_oracle_media_#{zip_file}" do
    command "unzip -o #{File.basename(zip_file)} -d /tmp/pan1"
    user "root"
    group 'root'
    cwd "/tmp/install"
  end
end

mount "/tmp/install" do
  device "10.10.0.2:/srv/software/Oracle/sql_11g"
  action :umount
end

