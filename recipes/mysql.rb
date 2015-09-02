#
# Cookbook Name:: nginx_drupal
# Recipe:: mysql
#
# Copyright (C) 2015 Knectar
# 
# All rights reserved - Do Not Redistribute
#

#creating mysql server 

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password node['nginx_drupal']['root_passswprd']
  bind_address '127.0.0.1'
  socket '/var/run/mysqld/mysqld.sock'
  action [:create, :start]
end

mysql_config 'default' do
  source 'mysite.cnf.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end

#install the mysql client

mysql_client 'default' do
  action :create
end
