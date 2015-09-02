if node['nginx_drupal']['mysql']['root_passswprd'].nil?
  default['nginx_drupal']['mysql']['root_passswprd'] = SecureRandom.hex(20)
end
