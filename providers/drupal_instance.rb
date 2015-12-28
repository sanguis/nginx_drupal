#
# Author:: Josh Beauregard <josh.beauregard@knectar.com>
# Cookbook Name:: nginx_drupal
# Provider:: drupal_instance
#
require 'uri'
require 'securerandom'

use_inline_resources if defined?(use_inline_resources)

def primary_url
  new_resource.url.first
end

def shortname
  primary_url.to_s.gsub(/^www\./, '').gsub(/\./, '_').slice(0, 6)
end

def site_alias
  "#{shortname}.#{new_resource.instance}"
end

def server_name
  new_resource.url.join(' ')
end

def app_path
  if new_resource.app_path.nil?
    return "/srv/www/#{site_alias}"
  else
    return new_resource.app_path
  end
end

def passwd_file
  "/home/#{app_owner}/#{site_alias}_passwd"
end

def passwd
  if new_resource.passwd.nil?
    return []
  else
    return new_resource.passwd
  end
end

def db
  db = new_resource.db.to_hash
  db['user'] = (db['user'].nil? && site_alias) || db['user']
  db['db'] = (db['db'].nil? && site_alias) || db['db']
  db['password'] = (db['password'].nil? && SecureRandom.hex(20)) || db['password']
  db['host'] = (db['host'].nil? && 'localhost') || db['host']
  db['prefix'] = (db['prefix'].nil? && '') || db['prefix']
  return db
end

def mysql_connection_info
  {
    host: new_resource.db['host'],
    username: 'root',
    password: node['nginx_drupal']['mysql']['root_password']
  }
end

def app_owner
  if new_resource.app_owner.nil?
    return site_alias
  else
    return new_resource.app_owner
  end
end

action :create do
  # TODO: create file system
  # application directory
  directory "#{app_path}/sites/#{new_resource.sites_directory}" do
    owner app_owner
    group node['nginx']['user']
    mode '0755'
    recursive TRUE
    action :create
  end

  # public files
  directory "#{app_path}/#{new_resource.public_files}" do
    owner node['nginx']['user']
    recursive true
    mode '0755'
    action :create
  end
  # private files
  directory "#{app_path}/#{new_resource.private_files}" do
    owner node['nginx']['user']
    recursive true
    mode '0755'
    action :create
  end
  ## create passwd file
  unless passwd.empty?
    file passwd_file do
      owner app_owner
      mode '0644'
      content passwd.join('\n')
      action :create
    end
  end

  ## drupal settings file
  template "#{app_path}/sites/#{new_resource.sites_directory}/settings.php" do
    cookbook 'nginx_drupal'
    source 'settings.php.erb'
    owner app_owner
    group node['nginx']['user']
    mode '0444'
    variables(
      db: site_alias,
      db_host: db.host,
      db_user: db.user,
      db_password: db.password,
      db_prefix: db.prefix,
      extra_settings: new_resource.extra_settings
    )
  end

  ## create vhost file
  template "/etc/nginx/sites-enabled/#{site_alias}.conf" do
    cookbook 'nginx_drupal'
    source 'vhost.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      ssl_crt: new_resource.ssl_crt,
      ssl_key: new_resource.ssl_key,
      ssl_chain: new_resource.ssl_chain,
      url: server_name,
      primary_url: primary_url,
      app_path: app_path,
      passwd_file: passwd_file,
      passwd_text: new_resource.passwd_text,
      private_files: new_resource.private_files
    )
    action :create
    # notifies :restart, 'service[nginx]', :delayed
  end
  # TODO: create add ssl
  # TODO: create database
  #  database site_alias do
  #    connection mysql_connection_info
  #    provider   Chef::Provider::Database::Mysql
  #    action :create
  #  end
  #
  # mysql_database_user site_alias do
  #  connection mysql_connection_info
  #  password db_password
  #  database_name site_alias
  #  action :create
  # end

  # TODO: create drush alieas
  Chef::Log.info('created drupal_instance')
  new_resource.updated_by_last_action(true)
end
action :delete do
  # TODO: delete file system
  # TODO: delete vhost file
  # TODO: delete database
  # TODO: delete drush alieas
  cookbook_file '/etc/cron.hourly/drupal.cron.sh' do
    source 'drupal.cron.sh'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
  Chef::Log.info('deleted drupal_instance')
  new_resource.updated_by_last_action(true)
end
