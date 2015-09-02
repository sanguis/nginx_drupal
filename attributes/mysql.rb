require 'securerandom'

defualt['nginx_drupal']['mysql']['root_passsword'] = ''
if node['nginx_drupal']['mysql']['root_passsword'].nil?
  default['nginx_drupal']['mysql']['root_passsword'] = SecureRandom.hex(20)
end
