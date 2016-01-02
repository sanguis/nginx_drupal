# spec_default.rb
require 'chefspec'
require 'chefspec/berkshelf'

describe 'nginx_drupal::default' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'Creates a Empty Drupal instance' do
    expect(chef_run).to create_instance('create_instance')
  end
end
