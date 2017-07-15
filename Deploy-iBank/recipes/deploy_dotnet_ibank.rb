#
# Cookbook Name:: Deploy-iBank-codar
# Recipe:: deploy_dotnet_ibank
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?('windows')
   # create temp folder
   directory "C:/tmp_chef/" do
	action :create
   end

   # download iBank Investor package
   remote_file "C:/tmp_chef/iBank.zip" do
  	source node['artifact_http_url']
  	action :create
   end

   # Deploy dotNet iBank Investor application package
   batch "unzip_and_deploy_IIS_package" do
	code <<-EOH
	"#{node['7zip_home_path']}" x C:/tmp_chef/iBank.zip -oC:/tmp_chef/iBank -r -y
	cd "C:/tmp_chef/iBank/Package/"
	set MSDeployPath=#{node['ms_deploy_home_path']}
	MyProj.Web.deploy.cmd /Y
	Icacls #{node['iBank-dotnet_iis_folder']} /grant:r "#{node['iBank-dotnet_permissions']}":(OI)(CI)F
	EOH
   end

   # Update iBank java application access details
   template node['iBank-java_ws_conf_file'] do
  	source "ws_conf_file.erb"
  	variables({
    		:host => "#{node['iBank-java_host']}",
		:port => "#{node['iBank-java_port']}",
		:app => "#{node['iBank-java_app']}"
  	})
   end

   # restart IIS server
   batch "reset_IIS" do
	code "iisreset"
   end
else
   Chef::Log.warn('iBank Investor application is only required for Windows platform.')
end


