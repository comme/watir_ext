#coding:utf-8
require 'webrick'
include WEBrick
s = HTTPServer.new(
    :port         => 2000,
    :DocumentRoot => File.join(__FILE__, '..', "/html")
)
trap("INT") { s.shutdown }
s.start