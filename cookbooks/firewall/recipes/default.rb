#
# Cookbook Name:: firewall
# Recipe:: default
#
# Copyright 2011, Keith Hudgins
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


service 'networking' do
  action :enable
  supports :restart => true
end

template '/etc/network/interfaces' do
  action :create
  source 'interfaces.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables( :interfaces => node[:firewall][:interfaces] )
  notifies :restart, 'service[networking]'
end 

# This is persistent.
template '/etc/network/interfaces' do
  action :create
  source 'sysctl.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# So we don't have to reboot, manually enable forwarding if it's not currently:
execute "enable ipv4 forwarding" do
  command "echo 1 > /proc/sys/net/ipv4/ip_forward"
  action :run
  not_if {`cat /proc/sys/net/ipv4/ip_forward`.chomp == '1'}
end

execute "rclocal" do
  command "/etc/rc.local"
  action :nothing
end

template '/etc/rc.local' do
  source 'rc.local.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables( :interfaces => node[:firewall][:interfaces] )
  notifies :run, 'execute[rclocal]', :immediately
end
