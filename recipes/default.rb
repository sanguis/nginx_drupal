#
# Cookbook Name:: nginx_drupal
# Recipe:: default
#
# Copyright (C) 2013 Knectar
# 
# All rights reserved - Do Not Redistribute
#

template "/etc/nginx/apps/drupal" do
  source "drupal.erb"
  action :create
end

template "/etc/nginx/conf.d/micro.conf" do
  source "micro.conf.erb"
  action :create
end

template "/etc/nginx/templates/VHOST.conf" do
  source "VHOST.conf.erb"
  variables({
    :private_dir => "sites/default/files/private"
  })
  action :create
end
