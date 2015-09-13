Josh Beauregard (sanguis)'s nginx_drupal cookbook
=============================

nginx_drupal (1.0.3) Prepaires a LEMP stack for a Drupal install

# nginx_drupal cookbook

# Usage
Installs an app template for vhosts to include that contains a common set of drupal inc files.

# Author

Author:: Josh Beauregard (josh.beauregard@knectar.com)


Requirements
------------

### Platforms

### Dependencies

`nginx >= 0.0.0`

`mysql >= 0.0.0`

`php >= 0.0.0`

`composer >= 0.0.0`


Attributes
----------


Recipes
-------

Testing and Utility
-------
    <Rake::Task default => [test]>

    <Rake::Task foodcritic => []>
      Run Foodcritic lint checks

    <Rake::Task integration => [kitchen:all]>
      Alias for kitchen:all

    <Rake::Task kitchen:all => [default-ubuntu-1404, default-centos-71]>
      Run all test instances

    <Rake::Task kitchen:default-centos-71 => []>
      Run default-centos-71 test instance

    <Rake::Task kitchen:default-ubuntu-1404 => []>
      Run default-ubuntu-1404 test instance

    <Rake::Task readme => []>
      Generate the Readme.md file.

    <Rake::Task rubocop => []>
      Run RuboCop style and lint checks

    <Rake::Task rubocop:auto_correct => []>
      Auto-correct RuboCop offenses

    <Rake::Task spec => []>
      Run ChefSpec examples

    <Rake::Task test => [rubocop, foodcritic, spec]>
      Run all tests

License and Authors
------------------

The following engineers have contributed to this code:
 * [Josh Beauregard](https://github.com/sanguis) - 86 commits

Copyright:: 2014-2015, [Knectar](https://www.knectar.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributing
------------

We welcome contributed improvements and bug fixes via the usual workflow:

1. Fork this repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
