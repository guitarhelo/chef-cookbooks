#
# Cookbook Name:: nunit
# Recipe:: default
#
# Copyright 2014, HP

bin_path =node['nunit']['home']+ "\\bin"
windows_package node['nunit']['package_name'] do
  source node['nunit']['url']
  checksum node['nunit']['checksum']
  options "INSTALLDIR=\"#{node['nunit']['home']}\""
  action :install
end

# update path
windows_path bin_path  do
  action :add
end
