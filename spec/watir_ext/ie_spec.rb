#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::IE do
  context "#ie_version" do
    before :each do
      @ie = Watir::IE.new
    end
    after :each do
      @ie.close
    end

    it "should be 8.0 when i use ie8" do
      @ie.ie_version.should eq("8.0")
    end
  end


  context "#contains_text" do
    before :each do
#    @ie = Watir::IE.start("http://localhost/nestedFrames.html")
      @ie = Watir::IE.start(html_page_path("nestedFrames.html"))
    end
    after :each do
      @ie.close
    end

    it "should return true when i try to find exist string" do
      @ie.contains_text("frames").should be_true
    end

    it "should return true when i try to find exist regexp" do
      @ie.contains_text(/frames/).should be_true
    end

    it "should return false when i try to find not exist string" do
      @ie.contains_text("not exist").should be_false
    end

    it "should return false when i try to find not exist regexp" do
      @ie.contains_text(/not exist/).should be_false
    end

    it "should raise Argument error when i pass a nil object" do
      lambda { @ie.contains_text(nil) }.should raise_error(ArgumentError)
    end

    it "should raise Argument error when i pass number" do
      lambda { @ie.contains_text(1) }.should raise_error(ArgumentError)
    end

    it "should raise Argument error when i pass class" do
      class A
      end
      lambda { @ie.contains_text(A.new) }.should raise_error(ArgumentError)
    end

    it "should return true when i try to find exist string" do
      @ie.contains_text("百度").should be_false
    end
  end

  context "#wait" do
    require 'watir_ext/ie_wait.rb'
    before :each do
      @ie = Watir::IE.new
    end
    after :each do
      @ie.terminate
    end
    it "should redirect to blank page if server response geater than 30 seconds" do
      @ie.goto("http://localhost/hello?timeout=60")
      @ie.contains_text("parameters").should be_false
    end
    it "should contains text frames when timeout equal 0" do
      @ie.goto("http://localhost/hello?timeout=0")
      @ie.contains_text("parameters").should be_true
    end
  end
  context ".attach_new" do
    it "should raise AugumentError when you don't call record" do
      lambda { Watir::IE.attach_new }.should raise_error(ArgumentError)
    end
    it "should raise Watir::NoMatchingWindowFoundException when no new window appear" do
      lambda do
        Watir::IE.record
        Watir::IE.attach_new
      end.should raise_error(Watir::NoMatchingWindowFoundException)
    end
    it "should attach success" do
      Watir::IE.record
      Watir::IE.start(html_page_path("nestedFrames.html"))
      ie=Watir::IE.attach_new
      ie.contains_text("frame").should be_true
      ie.close
    end
  end
  context "#terminate" do
    it "should be quit success" do
      ie = Watir::IE.new
      ie.terminate.should be_true
    end
    it "should be quit success with timeout : one(you should start http server at localhost:80)" do
      ie = Watir::IE.new
      begin
        Timeout.timeout(10) do
          ie.goto("http://localhost:80/hello?timeout=15")
        end
      rescue TimeoutError
        ie.terminate.should be_true
      end
    end
    it "should be quit success with timeout : two(you should start http server at localhost:80)" do
      ie = Watir::IE.new
      begin
        Timeout.timeout(10) do
          ie.goto("http://localhost:80/hello?timeout=15")
          ie.contains_text("parameters").should be_false
        end
      rescue TimeoutError
        ie.terminate
      end
    end
  end

end