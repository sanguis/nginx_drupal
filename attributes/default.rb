#
# Cookbook Name:: nginx_drupal
# Attributes:: default
#

default['nginx_drupal']['innodb']['default-storage-engine']		        = 'innodb'
default['nginx_drupal']['innodb']['innodb_log_file_size']		          = '10M'
default['nginx_drupal']['innodb']['/var/lib/mlkiysql/ib_logfile']     = '/var/lib/mlkiysql/ib_logfile*'
default['nginx_drupal']['innodb']['innodb_log_buffer_size']		        = '1M'
default['nginx_drupal']['innodb']['innodb_open_files']		            = 1024
default['nginx_drupal']['innodb']['ignore-builtin-innodb']            = 'ON'
default['nginx_drupal']['innodb']['plugin-load']                      = TRUE
