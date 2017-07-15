#
# Cookbook Name:: mswdt
# Recipe:: default
#
# Copyright 2014, HP
#
# All rights reserved
require 'chef/exceptions'

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, "This cookbook only works on Microsoft Windows."
end
windows_package node['mswdt']['package_name'] do
  source node['mswdt']['url']
  checksum node['mswdt']['checksum']
  options "INSTALLDIR=\"#{node['mswdt']['home']}\""
  action :install
end
#
