#coding: utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::Object do
  context "test 139 mail" do
    before :each do
      @ie = Watir::IE.start("http://mail.139.com")
      @ie.text_field(:id, "txtUserName").set("luphee")
      @ie.text_field(:id, "txtPassword").set("08hkfu@sangfor")
      @ie.button(:value, "登 录").click
      @ie.link(:id, "overridelink").click if @ie.link(:id, "overridelink").exist?
      @ie.link(:title, "写信").click
      @ie = Watir::IE.attach(:url, /10086/)
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
#
    it "should not show a file choice dialog if the position hidden 2" do
      ATT::FilePopup.record
      @ie.minimize
      o = @ie.frame(:name, /compose/).object(:id, "flashplayer")
      lambda { o.left_click(true) }.should raise_error(ATT::WindowNotFoundError)
    end

    it "should show a file choice dialog" do
      @ie.bring_to_front
      o = @ie.frame(:name, /compose/).object(:id, "flashplayer")
      ATT::FilePopup.record
      o.left_click(true)
      ATT::FilePopup.find.set(__FILE__)
      ie   = Watir::IE.attach(:url, /10086/)
      text = ie.frame(:name, /compose/).ul(:id, "attachContainer").text
      text.should be_include(File.basename(__FILE__))
    end

    after :each do
      @ie.close
    end
  end

  context "baidu tieba" do
    before :each do
      @ie        = Watir::IE.start("http://tieba.baidu.com/f?kw=%B6%B7%C6%C6%B2%D4%F1%B7")
      login_link = @ie.div(:id, "com_userbar").link(:text, "登录")
      if login_link.exist?
        login_link.click
        @ie.text_field(:id, "PassInputUsername0").exist?
        @ie.text_field(:id, "PassInputUsername0").set("test_lovemm")
        @ie.text_field(:id, "PassInputPassword0").set("fuckyouall!")
        @ie.button(:text, "登录").click
      end
    end

    it "should show a file choice dialog after move frame" do
      @ie.maximize
      @ie.span(:class, 'image').click
      object = @ie.frame(:index, 1).object(:id, "tedmultiupload")
      object.exist?
      object.view
      ATT::FilePopup.record
      object.left_click
      lambda { ATT::FilePopup.find.set(__FILE__) }.should_not raise_error
    end

    after :each do
      @ie.close
    end
  end
end