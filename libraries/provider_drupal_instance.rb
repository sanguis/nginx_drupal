require 'chef/provider/lwrp_base'
class Chef
  class NginxDrupalInstanceBase < Chef::Provider::LWRPBase
    use_inline_resources if defined?(use_inline_resources)
    
    action :create do
      #todo: create file system
      #todo:create vhost file
      #todo: create database
      #todo: create drush alieas
    end
    action :delete do
      #todo: delete file system
      #todo:delete vhost file
      #todo: delete database
      #todo: delete drush alieas
    end
  end
  
end
