#
# Cookbook Name:: nginx_drupal
# Recipe:: default
#
# Copyright (C) 2013 Knectar
# 
# All rights reserved - Do Not Redistribute
#

#create apps directory
remote_directory "/etc/nginx/apps" do
  files_group "root"
  files_owner "root"
  files_mode 00644
  owner "root"
  group "root"
  mode 00755
  action :create_if_missing
end

template "/etc/nginx/apps/drupal" do
  source "drupal.erb"
  action :create
end

#enable micro caching
template "/etc/nginx/conf.d/micro.conf" do
  source "micro.conf.erb"
  action :create
end

# create vhost templates

remote_directory "/etc/nginx/templates" do
  files_group "root"
  files_owner "root"
  files_mode 00644
  owner "root"
  group "root"
  mode 00755
  action :create_if_missing
end

template "/etc/nginx/templates/VHOST.conf" do
  source "VHOST.conf.erb"
  variables({
    :private_dir => "sites/default/files/private"
  })
  action :create
end
