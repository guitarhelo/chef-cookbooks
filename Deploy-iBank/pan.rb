# All rights reserved - Do Not Redistribute
#
include_recipe "winsoft::7-zip"
cba_package_path = win_friendly_path(File.join(Chef::Config['file_cache_path'], "cba_temp"))
cba_package_name = node['Deploy-CbaAccountTeam']['package']['name']
cba_remote_file= cba_package_path+"\\"+cba_package_name
cba_package_deploy_path=cba_package_path+"//Package/"
if platform?('windows')
   # create temp folder
   
   directory cba_package_path do
	action :create
   end

   # download CbaAccountTeam Investor package
   remote_file cba_remote_file do
  	source node['Deploy-CbaAccountTeam']['artifact']['http_url']
  	action :create
   end

   # Deploy dotNet CbaAccountTeam Investor application package
   batch "unzip_and_deploy_IIS_package" do
	code <<-EOH
	"7z x cba_remote_file -ocba_package_path -r -y
	cd cba_package_path+"//Package/"
	set MSDeployPath=#{node['Deploy-CbaAccountTeam']['ms_deploy']['home_path']}
	MyProj.Web.deploy.cmd /Y
	Icacls #{node['Deploy-CbaAccountTeam']['CbaAccountTeam-dotnet']['iis_folder']} /grant:r "#{node['Deploy-CbaAccountTeam']['CbaAccountTeam-dotnet']['permissions']}":(OI)(CI)F
	EOH
   end

   

   # restart IIS server
   batch "reset_IIS" do
	code "iisreset"
   end
else
   Chef::Log.warn('CbaAccountTeam Investor application is only required for Windows platform.')
end


