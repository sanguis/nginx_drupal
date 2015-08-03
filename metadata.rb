name             'nginx_drupal'
maintainer       'Josh Beauregard (sanguis)'
maintainer_email 'sanguisdex@gmail.com'
license          'All rights reserved'
description      'Installs/Configures nginx_drupal templates'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.1'

depends 'nginx'
depends 'mysql', '~> 6.0'
depends 'php'
