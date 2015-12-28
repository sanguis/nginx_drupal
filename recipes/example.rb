#
# Cookbook Name:: nginx_drupal
# Recipe:: Example
#
# Copyright (C) 2016 Josh Beauregard
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
user 'sites' do
  action :create
  comment 'drupal user'
  gid node['php']['fpm_group']
  home '/home/sites'
  shell '/bin/zsh'
end

nginx_drupal_drupal_instance ['example.dev'] do
  url ['www.test.dev', 'example.dev']
  # ssl_crt
  # ssl_key
  # ssl_chain
  passwd ['knectar:$apr1$KcTN/KIC$2pWUIc.Xi8q4pWKXQNT3z.']
  # passwd_text
  # app_path
  # public_files
  # private_files
  app_owner 'sites'
end
