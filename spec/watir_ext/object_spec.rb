#coding: utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::Object do
  before :each do
    @ie = Watir::IE.start("http://mail.139.com")
    @ie.text_field(:id, "txtUserName").set("luphee")
    @ie.text_field(:id, "txtPassword").set("08hkfu@sangfor")
    @ie.button(:value, "登 录").click
    @ie.link(:id, "overridelink").click if @ie.link(:id, "overridelink").exist?
    @ie.link(:title, "写信").click
#    @ie = Watir::IE.attach(:url,/10086/)
  end

  it "should show a file choice dialog" do
    ATT::FilePopup.record
    @ie.bring_to_front
    o = @ie.frame(:name, /compose/).object(:id, "flashplayer")
    o.left_click
    file_upload_window = ATT::FilePopup.find
    file_upload_window.set(__FILE__)
    ie   = Watir::IE.attach(:url, /10086/)
    text = ie.frame(:name, /compose/).ul(:id, "attachContainer").text
    text.should be_include(File.basename(__FILE__))
  end

  it "should not show a file choice dialog if the position hidden" do
    ATT::FilePopup.record
    @ie.minimize
    o = @ie.frame(:name, /compose/).object(:id, "flashplayer")
    o.left_click
    lambda { ATT::FilePopup.find }.should raise_error(ATT::WindowNotFoundError)
  end

  it "should not show a file choice dialog if the position be cover" do
    begin
      ATT::FilePopup.record
      ie = Watir::IE.new
      ie.maximize
      o = @ie.frame(:name, /compose/).object(:id, "flashplayer")
      o.left_click
      lambda { ATT::FilePopup.find }.should raise_error(ATT::WindowNotFoundError)
    ensure
      ie.close
    end
  end

  after :each do
    @ie.close
  end
end