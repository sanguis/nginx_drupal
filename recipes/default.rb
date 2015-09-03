#
# Cookbook Name:: nginx_drupal
# Recipe:: default
#
# Copyright (C) 2015 Knectar
# 
# All rights reserved - Do Not Redistribute
#

mysql2_chef_gem 'default' do
  action :install
end

#create apps directory
remote_directory "apps" do
  path "/etc/nginx/apps"
  files_group "root"
  files_owner "root"
  files_mode 00644
  owner "root"
  group "root"
  mode 00755
  action :create_if_missing
end
#enable micro caching
template "/etc/nginx/conf.d/micro.conf" do
  source "micro.conf.erb"
  action :create
end

# create vhost templates

 remote_directory "templates" do
   path "/etc/nginx/templates"
   files_group "root"
   files_owner "root"
   files_mode 00644
   owner "root"
   group "root"
   mode 00755
   action :create_if_missing
 end

directory '/etc/nginx/snippets' do
  owner 'root'
  group 'root'
  mode '0755'

  action :create
end

cookbook_file '/etc/nginx/snippets/password.conf' do
  source 'password.conf'
  backup 5
  owner 'root'
  group 'root'
  mode '0644'

  action :create
end

directory '/etc/nginx/sites-enabled' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/nginx/conf.d/ssl.conf' do
  source 'nginx.conf.d/ssl.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
directory '/etc/drush' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

