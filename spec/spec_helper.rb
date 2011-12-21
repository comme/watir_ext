#coding:utf-8
unless $LOADED
  WATIR_EXT_DIR = File.expand_path(File.join(File.expand_path(__FILE__), '..', '..'))
  $LOAD_PATH.unshift File.join(WATIR_EXT_DIR, 'lib')
  $LOADED = true
end
gem 'watir', '1.6.5'
require File.join(WATIR_EXT_DIR, 'spec', 'spec_ext')
require File.join(WATIR_EXT_DIR, 'spec', 'string_ext')
require 'rspec'
require 'popup'
require 'watir_ext'
require File.join(WATIR_EXT_DIR, 'spec', 'support', 'server')

class WatirExtHelper
  class <<self
    def html_page_path(page_name)
      @server || start_server
      at_exit { close rescue nil }
#      myDir = File.join(WATIR_EXT_DIR, 'spec', 'support')
#      "file://#{myDir}/html/#{page_name}"
      "http://localhost:#{@port}/#{page_name}"
    end

    def url_path
      @server || start_server
      at_exit { close rescue nil }
      "http://localhost:#{@port}"
    end

    def start_server
      @server = WatirExtServer.new
      @port   = @server.port
      @server.start
    end

    def close
      @server.close
    end
  end
end