#
# Cookbook Name:: cron
# Recipe:: default
#
# Copyright 2011, Keith Hudgins
#
# All rights reserved - Do Not Redistribute
#

%w{vixie-cron anacron crontabs}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{crond anacron}.each do |svc|
  service svc do
    supports :status => true, :restart => true
    action [:enable, :start]
  end
end
    