#
# Author:: Keith Hudgins (<greenman@greenman.org>)
# Cookbook Name:: minecraft
# Attributes:: default
#
# Copyright 2010, Keith Hudgins
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

case platform
when "centos","redhat","fedora"
  default['java']['version'] = "6u25"
  default['java']['arch'] = kernel['machine'] =~ /x86_64/ ? "amd64" : "i586"
  set['java']['java_home'] = "/usr/lib/jvm/java"
else
  set['java']['java_home'] = "/usr/lib/jvm/default-java"
end

default['minecraft']['backupdir'] = '/srv/minecraft/backups/'
default['minecraft']['bukkitdir'] = '/srv/minecraft/'
default['minecraft']['bukkitfilename'] = 'craftbukkit.jar'
default['minecraft']['bukkitupdate'] = 'craftbukkit-updater.jar'
default['minecraft']['javaloc'] = `which java`
default['minecraft']['javaheapmax'] = '1024M'
default['minecraft']['javaheapinit'] = '1024M'
default['minecraft']['worlds'] = 'world nether'
default['minecraft']['bukkiturl'] = 'http://ci.bukkit.org/job/dev-CraftBukkit/promotion/latest/Recommended/artifact/target/craftbukkit-0.0.1-SNAPSHOT.jar'

default['minecraft']['seed'] = '4928722362665752835'
default['minecraft']['whitelist'] = 'true'
default['minecraft']['pvp'] = 'true'
default['minecraft']['users'] = ['khudgins', 'doboy']
default['minecraft']['ops'] = ['khudgins', 'doboy']
