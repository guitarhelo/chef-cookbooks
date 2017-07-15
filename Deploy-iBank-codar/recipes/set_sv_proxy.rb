#
# Cookbook Name:: Deploy-iBank
# Recipe:: set_sv_proxy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


if platform?('windows')
   # Update iBank dotNet application sv proxy
   template node['sv_web_config_file'] do
  	source "web_config.erb"
  	variables({
    		:sv_proxy => "#{node['sv_proxy']}"
  	})
   end

   # restart IIS server
   batch "reset_IIS" do
	code "iisreset"
   end
else
   Chef::Log.warn('iBank dotNet SV proxy is only required for Windows platform.')
end

