#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "rspec/core/rake_task"
require "bundler/gem_tasks"

task :default => :spec
desc "Run the test suite"
RSpec::Core::RakeTask.new

Dir.glob('lib/tasks/*.rake').each { |r| import r }
