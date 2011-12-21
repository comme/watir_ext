#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::IE do
  it "should be non-block" do
    ie =Watir::IE.start(html_page_path("fileupload.html"))
    ff = ie.file_field(:name, "file1")
    ATT::Popup.record
    ff.click_no_wait
    w = ATT::Popup.find
    w.should be_instance_of(ATT::Popup)
    w.close
    ie.close
  end
end