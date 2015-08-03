name             'nginx_drupal'
maintainer       'Josh Beauregard (sanguis)'
maintainer_email 'sanguisdex@gmailcom'
license          'All rights reserved'
description      'Installs/Configures nginx_drupal templates'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'nginx'
depends 'mysql'
depends 'php'
