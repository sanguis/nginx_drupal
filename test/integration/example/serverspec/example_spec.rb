require 'spec_helper'

package('nginx') do
  it { should be_installed }
end
describe service('nginx') do
  it { should be_running }
end


package('mysql-server') do
  it { should be_installed }
end
describe service('mysql') do
  it { should be_running }
end

package('php-fpm') do
  it { should be_installed }
end
describe service('php-fpm') do
  it { should be_running }
end


