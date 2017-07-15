#
# Cookbook Name:: Deploy-iBank-java-codar
# Recipe:: install_unzip
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node["os"] == 'linux'
  package "unzip" do
    action :install
  end
else
  Chef::Log.warn('unzip package is only required for linux distributions.')
end