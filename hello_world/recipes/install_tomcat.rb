#
# Cookbook Name:: Deploy-iBank-java-codar
# Recipe:: install_tomcat
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node["os"] == 'linux'
  # create temp folder
  directory "/tmp_logindemo" do
    owner "root"
    mode "0755"
    action :create
  end

  # Download tomcat
  remote_file "/tmp_logindemo/apache-tomcat.zip" do
    source node['logindemo_tomcat_http_url']
    action :create_if_missing
  end

  # Install tomcat
  bash 'extract_tomcat' do
    user "root"
    cwd "/tmp_logindemo"
    code <<-EOH
      unzip apache-tomcat.zip
      mv apache-tomcat-* apache-tomcat
      chmod -R +x apache-tomcat
    EOH
    not_if { ::File.exists?("/tmp_logindemo/apache-tomcat/bin/startup.sh") }
  end
else
  Chef::Log.warn('tomcat package is only required for linux distributions.')
end