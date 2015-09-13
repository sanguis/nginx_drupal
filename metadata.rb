name 'nginx_drupal'
maintainer 'Josh Beauregard (sanguis)'
maintainer_email 'josh.beauregard@knectar.com'
license 'All rights reserved'
description 'Installs/Configures nginx_drupal templates'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.3'

depends 'nginx'
depends 'mysql'
depends 'php'
depends 'composer'
