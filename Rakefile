require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:spec_junit) do |t|
  t.rspec_opts = ['--format RspecJunitFormatter', '--out rspec_report.xml']
  t.pattern    = '**/*_spec.rb'
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop_default)
RuboCop::RakeTask.new(:rubocop_progress) do |t|
  t.formatters = %w(progress)
  t.options    = %w(--out rubocop_report.txt)
end

RuboCop::RakeTask.new

task default:        %w(spec rubocop_default)
task test:           :spec
task styles:         :rubocop_default
task test_junit:     :spec_junit
task style_progress: :rubocop_progress
