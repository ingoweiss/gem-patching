require 'rake/testtask'

desc 'Run test/unit tests'
Rake::TestTask.new(:test) { |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
}

task :default => [:test]