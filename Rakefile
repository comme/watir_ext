#coding: utf-8
begin
  require 'rspec'
rescue LoadError
  begin
    require 'rubygems'
    require 'rspec'
  rescue LoadError
    puts <<-EOS
    To use rspec for testing you must install rspec gem:
        gem install rspec
    EOS
    exit(0)
  end
end
require 'rspec/core/rake_task'
#namespace :watirextspec do
desc "Run the specs under #{File.join(File.expand_path(__FILE__), "..", "spec", "watir_ext")}"
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "#{File.join(File.expand_path(__FILE__), "..", "spec", "watir_ext")}/*_spec.rb"
end
#end