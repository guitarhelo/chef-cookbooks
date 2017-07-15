#
# Cookbook Name:: Deploy-iBank
# Recipe:: set_ie_proxy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


if platform?('windows')
   # Configure IE proxy for iBank SV service
   batch "unzip_and_deploy_IIS_package" do
	code <<-EOH
	reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
	reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyServer /t REG_SZ /d #{node['ie_proxy_host']} /f
	reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings" /v ProxyOverride /t REG_SZ /d #{node['ie_proxy_exceptions']} /f
	EOH
   end
else
   Chef::Log.warn('MS web deployment tools is only available for Windows platform.')
end