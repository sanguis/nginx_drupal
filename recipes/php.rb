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
include_recipe 'composer'

# install php fpm
php_fpm_pool 'default' do
  listen node['nginx_drupal']['php']['fpm_listen']
  action :install
end

# APC and dependacies
case node['platform_family']
when 'rhel', 'fedora'
  %w( zlib-devel httpd-devel pcre pcre-devel ).each do |pkg|
    package pkg do
      action :install
    end
    php_pear 'memcache' do
      action :install
      # directives(:shm_size => "128M", :enable_cli => 0)
    end
  end
when 'debian'
  %w( php5-memcache php5-gd php5-mysql ).each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end

# APC and dependacies
if node['php']['version'].to_f > 5.5

  php_pear 'apc' do
    action :install
    directives(
      shm_segments: node['nginx_drupal']['shm_segments'],
      shm_size: node['nginx_drupal']['shm_size '],
      ttl: node['nginx_drupal']['ttl'],
      user_ttl: node['nginx_drupal']['user_ttl'],
      enable_cli: node['nginx_drupal']['enable_cli'],
      stat: node['nginx_drupal']['stat'],
      stat_ctime: node['nginx_drupal']['stat_ctime'],
      lazy_classes: node['nginx_drupal']['lazy_classes'],
      lazy_functions: node['nginx_drupal']['lazy_functions'],
      write_lock: node['nginx_drupal']['write_lock'],
      rfc1867: node['nginx_drupal']['rfc1867']
    )
  end
end

composer_project node['drush']['install_dir'] do
  action :update
end
