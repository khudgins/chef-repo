#
# Cookbook Name:: minecraft
# Recipe:: minecraft
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
# This recipe installs the minecraft server and gets it running on your box.
# Currently, I'm only working on CentOS. No promises this works AT ALL on non RHEL
# systems. I'm writing this to be cross-platform... but until I build this on a
# debian/ubuntu system, I'm not promising a damn thing. ;P

pkgs = value_for_platform(
  ["centos","redhat","fedora"] => {
    "default" => ["screen"]
  },
  "default" => ["screen"]
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

user "bukkit" do
  action :create
  home "/home/bukkit"
  shell "/bin/bash"
end

template "/etc/init.d/bukkit" do
  source "bukkit.erb"
  owner "bukkit"
  group "bukkit"
  mode "0755"
end

directory "/srv/minecraft/backups" do
  owner "bukkit"
  group "bukkit"
  mode "0755"
  recursive true
  action :create
end

["ops.txt", "white-list.txt", "server.properties"].each do |config|
  template "/srv/minecraft/#{config}" do
    owner "bukkit"
    group "bukkit"
    mode "0644"
    source "#{config}.erb"
  end
end
  

remote_file "/srv/minecraft/#{node[:minecraft][:bukkitfilename]}" do
  source node[:minecraft][:bukkiturl]
  mode "0644"
  owner "bukkit"
  group "bukkit"
  backup 2
end

service "bukkit" do
  action [:enable, :start]
  supports :restart => true
  pattern 'SCREEN -S bukkit'
end