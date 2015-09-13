require 'chefspec'

describe 'nginx_drupal::default' do
let(:chef_run) {
   ChefSpec::Runner.new.converge(described_recipe)
}  

it 'creates a file' do    
   expect(chef_run).to create_file('/tmp/myfile.txt')  
end
end
