#
# Cookbook Name:: nginx_drupal
# Recipe:: default
#
# Copyright (C) 2015 Knectar
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
if default['php']['version'] > 5.5
  case node['platform_family']
  when 'rhel', 'fedora'
    %w{ httpd-devel pcre pcre-devel }.each do |pkg|
      package pkg do
        action :install
      end
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
end

cookbook_file '/etc/nginx/conf.d/ssl.conf' do
  source 'nginx.conf.d/ssl.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
