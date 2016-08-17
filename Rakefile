require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)
task :test => :spec

YARD::Rake::YardocTask.new(:yard)
task :doc => :yard

task :console do
  require 'flic'
  require 'pry'
  Pry.start
end

task :default => [:spec, :doc]