#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::TextField do
  before :each do
    @ie         = Watir::IE.start(html_page_path("textfields1.html"))
    @text_field = @ie.text_field(:index, 1)
  end
  after :each do
    @ie.close
  end
  it "should set right gbk words if win32ole.codepage is cp_acp and words encoding is gbk" do
    temp              = WIN32OLE.codepage
    WIN32OLE.codepage = WIN32OLE::CP_ACP
    @text_field.set("你好".to_gbk)
    @text_field.value.should_not == "你好"
    @text_field.value.should == "你好".to_gbk
    WIN32OLE.codepage = temp
  end
  it "should set right utf-8 words if win32ole.codepage is cp_utf8 and words encoding is utf-8" do
    temp              = WIN32OLE.codepage
    WIN32OLE.codepage = WIN32OLE::CP_UTF8
    @text_field.set("你好")
    @text_field.value.should_not == "你好".to_gbk
    @text_field.value.should == "你好"
    WIN32OLE.codepage = temp
  end
end