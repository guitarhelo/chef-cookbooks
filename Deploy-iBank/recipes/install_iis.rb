#
# Cookbook Name:: Deploy-iBank
# Recipe:: install_iis
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform?('windows')
   # Setup ASP.NET 64
   batch "setup AspNet" do
  	code node['Deploy-iBank']['ms_dotnet45']['reg64_cmd']
   end

   # Install IIS role and features
   %w[IIS-WebServerRole IIS-WebServer IIS-CommonHttpFeatures IIS-StaticContent IIS-DefaultDocument IIS-DirectoryBrowsing IIS-HttpErrors IIS-HttpRedirect IIS-ApplicationDevelopment IIS-RequestFiltering IIS-NetFxExtensibility IIS-ISAPIFilter IIS-ISAPIExtensions IIS-ASPNET IIS-ServerSideIncludes IIS-HealthAndDiagnostics IIS-HttpLogging IIS-LoggingLibraries IIS-RequestMonitor IIS-HttpTracing IIS-Security IIS-Performance IIS-HttpCompressionStatic IIS-HttpCompressionDynamic IIS-WebServerManagementTools IIS-ManagementConsole IIS-ManagementScriptingTools IIS-ManagementService].each do |feature|
   	windows_feature feature do
   		action :install
   	end
   end

	# Setup ASP.NET
   batch "setup AspNet" do
	code node['Deploy-iBank']['ms_dotnet45']['reg_cmd']
   end
else 
   Chef::Log.warn('IIS is only required for Windows platform.')
end








