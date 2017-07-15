# Cookbook Name:: Deploy-iBank-java-codar
# Recipe:: install_java
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

if platform?('ubuntu')
  # Install tomcat
  bash 'update_apt_repo' do
    user "root"
    code <<-EOH
      apt-get update
    EOH
  end

  unless File.exists?('/usr/bin/java')
    package "openjdk-7-jdk" do
          action :install
    end
  end
else
  Chef::Log.warn('openjdk-7-jdk package is only required for Ubuntu linux distribution.')
end