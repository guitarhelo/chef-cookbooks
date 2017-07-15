#
# Cookbook Name:: mstfs
# Recipe:: online_install
#
# Copyright 2014, HP
#
# All rights reserved 
windows_package node['mstfs']['package_name'] do
  source node['mstfs']['url']
  checksum node['mstfs']['checksum']
  options "/quiet INSTALLDIR=\"#{node['mstfs']['home']}\""
  action :install
end
#
