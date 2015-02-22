require 'rspec/core/rake_task'

desc 'run the blog'
task :run do
  `shotgun -p 8583`
end

namespace :spec do
  desc 'Run unit specs'
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.rspec_opts = '--color --format progress --tag ~@integration'
    task.verbose = false
  end

  desc 'Run integration specs'
  RSpec::Core::RakeTask.new(:integration) do |task|
    task.rspec_opts = '--color --format progress --tag @integration'
    task.verbose = false
  end

  desc 'Run specs'
  RSpec::Core::RakeTask.new(:all) do |task|
    task.rspec_opts = '--color --format progress'
    task.verbose = false
  end
end

desc "Run specs and report coverage to CodeClimate"
RSpec::Core::RakeTask.new(:ci) do |task|
  task.rspec_opts = "-color --format progress --require coverage_reporter"
  task.verbose = false
end

task default: ['spec:unit']
