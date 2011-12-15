#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')# if __FILE__ == $0
describe Watir::Frame do
  before :each do
    @ie = Watir::IE.start("http://localhost/frame_multi.html")
  end
  after :each do
#    @ie.close
  end

  context "#contains_text" do
    it "should return true when i try to find exist string" do
      @ie.contains_text("button").should be_true
    end
  end
end