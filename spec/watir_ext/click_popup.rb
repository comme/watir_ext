#coding: utf-8
require 'rubygems'
require 'win32ole'
WIN32OLE.codepage = WIN32OLE::CP_UTF8
autoit            = WIN32OLE.new('AutoItX3.Control')
if autoit.winwait('选择要加载的文件', '', 60) != 0
  autoit.winclose('选择要加载的文件', '')
end