# encoding: utf-8
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'kitchen/rake_tasks'
require 'drud'

desc 'Generate the Readme.md file.'
task :readme do
  drud = Drud::Readme.new(File.dirname(__FILE__))
  drud.render
end

desc 'Run RuboCop style and lint checks'
RuboCop::RakeTask.new(:rubocop)

desc 'Run Foodcritic lint checks'
FoodCritic::Rake::LintTask.new(:foodcritic)

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests'
task test: [:rubocop, :foodcritic, :spec]
task default: :test

Kitchen::RakeTasks.new
desc 'Alias for kitchen:all'
task integration: 'kitchen:all'
