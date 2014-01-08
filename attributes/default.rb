#
# Cookbook Name:: nginx_drupal
# Attributes:: default
#

default['innodb']['default-storage-engine']		        = 'innodb'
default['innodb']['innodb_buffer_pool_size']		      = '300M'
default['innodb']['innodb_log_file_size']		          = '10M'
default['innodb']['/var/lib/mlkiysql/ib_logfile']     = '/var/lib/mlkiysql/ib_logfile*'
default['innodb']['innodb_flush_method']		          = 'O_DIRECT'
default['innodb']['innodb_file_per_table']		        = 1
default['innodb']['innodb_flush_log_at_trx_commit']		= 2
default['innodb']['innodb_log_buffer_size']		        = '1M'
default['innodb']['innodb_additional_mem_pool_size']	= '20M'
# num cpu's/cores x2 is a good base line for thread concuracy
default['innodb']['innodb_thread_concurrency']		    = 8
default['innodb']['innodb_open_files']		            = 1024
default['innodb']['ignore-builtin-innodb']            = 'ON'
default['innodb']['innodb_file_per_table']            = 'ON'
default['innodb']['plugin-load']                      = TRUE
