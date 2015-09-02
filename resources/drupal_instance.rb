#
# Author:: Josh Beauregard <josh.beauregard@knectar.com>
# Cookbook Name:: nginx_drupal
# Resource:: drupal_instance
#

default_action :create

actions :create, :delete

attribute :url, :kind_of => Array, :requred => true, :name_attribute => true
attribute :instance, :kind_of => String, :default => 'production'
attribute :ssl_crt, :kind_of => String
attribute :ssl_key, :kind_of => String
attribute :ssl_chain, :kind_of => String
attribute :passwd, :kind_of => Array
attribute :passwd_text, :kind_of => String, :default => "Bots and Balrogs shall not pass"
attribute :app_path, :kind_of => String
attribute :public_files, :kind_of => String , :default => 'sites/default/files'
attribute :sites_directory, :kind_of => String , :default => 'default'
attribute :extra_settings, :kind_of => Hash
attribute :private_files, :kind_of => String, :default => 'sites/default/files/_private'
attribute :db, :kind_of => Hash, :default => {'user' => '', 'db' => '', 'password' => '', 'host' => 'localhost', 'prefix' => ''}
attribute :app_owner, :kind_of => String, :default => 'root'
