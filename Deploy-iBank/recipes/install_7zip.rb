#
# Cookbook Name:: Deploy-iBank
# Recipe:: install_7zip
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?('windows')
   unless File.exists?('C:/Program Files/7-Zip/7z.exe')
     windows_package "7zip" do
  	action :install
  	source node['Deploy-iBank']['7zip']['http_url']
     end
   end
else
   Chef::Log.warn('7zip is only required for Windows platform.')
end