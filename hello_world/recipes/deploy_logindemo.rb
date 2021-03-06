#
# Cookbook Name:: Deploy-iBank-java-codar
# Recipe:: deploy_logindemo
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node["os"] == 'linux'
 
  # Download LoginDemo java application package
  remote_file "/tmp_logindemo/logindemo.war" do
    source node['logindemo_artifact_http_url']
    action :create
  end

  # Deploy ibank java application
  bash 'deploy_LoginDemo' do
    user "root"
    code <<-EOH
      cp /tmp_logindemo/iBank.war /tmp_logindemo/apache-tomcat/webapps/logindemo.war
      /tmp_logindemo/apache-tomcat/bin/startup.sh
      sleep 30
    EOH
  end
else
  Chef::Log.warn('LoginDemo java application package is only required for linux distributions.')
end