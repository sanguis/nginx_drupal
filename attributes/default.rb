#
# Cookbook Name:: nginx_drupal
# Attributes:: default
#

default['nginx_drupal']['innodb']['default-storage-engine']		        = 'innodb'
default['nginx_drupal']['innodb']['innodb_log_file_size']		          = '10M'
default['nginx_drupal']['innodb']['/var/lib/mlkiysql/ib_logfile']     = '/var/lib/mysql/ib_logfile*'
default['nginx_drupal']['innodb']['innodb_log_buffer_size']		        = '1M'
default['nginx_drupal']['innodb']['innodb_open_files']		            = 1024
default['nginx_drupal']['innodb']['ignore-builtin-innodb']            = 'ON'
default['nginx_drupal']['innodb']['plugin-load']                      = TRUE
default['nginx_drupal']['apc']['shm_segments']	= '2'
default['nginx_drupal']['apc']['shm_size ']	= '256M'
default['nginx_drupal']['apc']['ttl']	= '7200'
default['nginx_drupal']['apc']['user_ttl']	= '7200'
default['nginx_drupal']['apc']['enable_cli']	= '1'
default['nginx_drupal']['apc']['stat']	= '0'
default['nginx_drupal']['apc']['stat_ctime']	= '1'
default['nginx_drupal']['apc']['lazy_classes']	= '1'
default['nginx_drupal']['apc']['lazy_functions']	= '1'
default['nginx_drupal']['apc']['write_lock']	= '1'
default['nginx_drupal']['apc']['rfc1867']   = '1'
  
