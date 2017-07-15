#
# Cookbook Name:: ms_dotnet
# Recipe:: default
# Author:: Jeremy Mauro (<j.mauro@criteo.com>)
#
# Copyright (C) 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

return unless platform?('windows')

include_recipe 'windows'
unless Chef::Config[:solo] or Chef::Config[:local_mode]
  include_recipe 'windows::reboot_handler'
end

windows_reboot 'ms_dotnet' do
  timeout 60
  reason 'Microsoft DotNet Installation'
  action :nothing
end
