require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'parallel_tests'
require 'parallel_tests/cli'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

desc "Parallel spec tests"
task :parallel_spec do
  Rake::Task[:spec_prep].invoke
  ParallelTests::CLI.new.run('--type test -t rspec spec/classes spec/defines'.split)
  Rake::Task[:spec_clean].invoke
end
