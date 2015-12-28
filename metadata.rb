name 'nginx_drupal'
maintainer 'Josh Beauregard (sanguis)'
maintainer_email 'josh.beauregard@knectar.com'
license 'All rights reserved'
description 'Prepaires a LEMP stack for a Drupal install'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.4'

supports 'ubuntu'
supports 'centos'

depends 'nginx', '~> 2.7.6'
depends 'mysql'
depends 'php'
depends 'composer'
depends 'mysql', '~> 6.1.0'
depends 'mysql2_chef_gem', '~> 1.0.2'
depends 'php'
depends 'zsh'
depends 'composer', '~> 2.2.0'
depends 'database'
depends 'memcached'

source_url 'https://github.com/sanguis/nginx_drupal' if respond_to?(:source_url)
issues_url 'https://github.com/sanguis/nginx_drupal/issues' if respond_to?(:issues_url)
