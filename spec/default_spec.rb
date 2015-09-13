require 'chefspec'

describe 'nginx_drupal::default' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'creates a file' do
    expect(chef_run).to create_file('/tmp/myfile.txt')
  end
end
