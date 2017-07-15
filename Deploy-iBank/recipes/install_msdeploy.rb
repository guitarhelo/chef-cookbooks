#
# Cookbook Name:: Deploy-iBank
# Recipe:: install_msdeploy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


if platform?('windows')
   unless File.exists?('C:/Program Files/IIS/Microsoft Web Deploy V3/msdeploy.exe')
     windows_package "Install MS web Deployment tool" do
  	action :install
  	source node['Deploy-iBank']['ms_deploy']['http_url']
	options "ADDLOCAL=ALL"
	action :install
     end
   end
else
   Chef::Log.warn('MS web deployment tools is only available for Windows platform.')
end