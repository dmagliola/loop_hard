require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :test_with_coveralls => ["test", "coveralls:push"]
