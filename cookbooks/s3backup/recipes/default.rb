#
# Cookbook Name:: s3backup
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

# Load credentials
aws = data_bag_item("aws", "main")

gem_package "aws-s3" do
  action :install
end

directory "/etc/aws" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/aws/s3.rb" do
  source "s3.rb.erb"
  owner "root"
  group "root"
  mode "0700"
  action :create
  variables(
    :access_key_id => aws['aws_access_key_id'],
    :secret_access_key => aws['aws_secret_access_key'],
    :backup_bucket => aws['s3_backup_bucket']
  )
end

%w{backup_files.rb backup_mysql.rb}.each do |script|
  cookbook_file "/usr/bin/#{script}" do
    source script
    owner "root"
    group "root"
  mode "0700"
  end
end

# Pseudocode stub:
# Template build crontab
# Template loops through databags for backup scripts
# Can be extended for any and all new backup script types
# (postgres backup, for example)

# Add crontab entry in /etc/cron.whenever for each line in the loop
# Datpoints needed
# job name
# type (file & mysql for now)
# targets (path and/or db names)
# schedule (daily, weekly, monthly, hourly)