#
# Cookbook Name:: nginx_drupal
# Recipe:: default
#
# Copyright (C) 2013 Knectar
# 
# All rights reserved - Do Not Redistribute
#

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

 template "/etc/nginx/templates/VHOST.conf" do
   source "VHOST.conf.erb"
   variables({
     :private_dir => "sites/default/files/private"
   })
   action :create
 end
 #added inodb settings
 template "/etc/mysql/conf.d/innodb.cnf" do
   source "innodb.cnf.erb"
   action :create
 end
 

## install php libs via pear
include_recipe 'php' 

#APC and dependacies
case node['platform_family']
when 'rhel', 'fedora'
  %w{ httpd-devel pcre pcre-devel }.each do |pkg|
    package pkg do
      action :install
    end
when 'debian'
  # Package resource
  package libprece3-dev do # Name of the package to install
    action :install # Install a package - if version is provided, install that specific version (Default)
  end
end

php_pear "apc" do
  action :install
  directives(
    :shm_segments=> node['nginx_drupal']['shm_segments'],
    :shm_size => node['nginx_drupal']['shm_size '],
    :ttl=> node['nginx_drupal']['ttl'],
    :user_ttl=> node['nginx_drupal']['user_ttl'],
    :enable_cli=> node['nginx_drupal']['enable_cli'],
    :stat=> node['nginx_drupal']['stat'],
    :stat_ctime=> node['nginx_drupal']['stat_ctime'],
    :lazy_classes=> node['nginx_drupal']['lazy_classes'],
    :lazy_functions=> node['nginx_drupal']['lazy_functions'],
    :write_lock=> node['nginx_drupal']['write_lock'],
    :rfc1867=> node['nginx_drupal']['rfc1867']
  )
end

=begin future needs
case node['platform_family']
when 'rhel', 'fedora'
  %w{ zlib-devel }.each do |pkg|
    package pkg do
      action :install
    end
  end
end

pears = [
  #'curl',
#  'memcache',
  #'gd',
  #'mysql'
]

pears.each do |pear|
  php_pear pear do
    action :install
  end
end
services = ["php5-fpm", "nginx"]

services.each do |ser|
  service ser do
    supports :status => true, :restart => true, :truereload => true
    action [ :enable, :start ]
  end
end
=end futreure needs
