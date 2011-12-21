#coding:utf-8
puts "__FILE__:#{File.expand_path(__FILE__)}"
WATIR_EXT_DIR = File.expand_path(File.join(File.expand_path(__FILE__), '..', '..'))
puts "WATIR_EXT_DIR:#{File.expand_path(WATIR_EXT_DIR)}"
$LOAD_PATH.unshift File.join(WATIR_EXT_DIR, 'lib') unless $LOADED
$LOADED = true
gem 'watir','1.6.5'
require File.join(WATIR_EXT_DIR, 'spec', 'spec_ext')
require File.join(WATIR_EXT_DIR, 'spec', 'string_ext')
require 'rspec'
require 'popup'
require 'watir_ext'
def html_page_path(page_name)
  myDir = File.join(WATIR_EXT_DIR, 'spec', 'support')
  "file://#{myDir}/html/#{page_name}"
end