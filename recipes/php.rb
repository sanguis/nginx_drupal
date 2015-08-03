#
# Cookbook Name:: nginx_drupal
# Recipe:: php
#
# Copyright (C) 2015 Knectar
# 
# All rights reserved - Do Not Redistribute
#

## install php libs via pear
include_recipe 'php' 

if node['php']['version'] > '5.5'
  #APC and dependacies
  case node['platform_family']
  when 'rhel', 'fedora'
    %w{ httpd-devel pcre pcre-devel }.each do |pkg|
      package pkg do
        action :install
      end
    end
  when 'debian'
    # Package resource
    package "libpcre3-dev" do 
      action :install
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
