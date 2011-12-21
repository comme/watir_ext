#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::Frame do
  before :each do
    @ie = Watir::IE.start(WatirExtHelper.html_page_path("frame_multi.html"))
  end
  after :each do
    @ie.close
  end

  context "#contains_text" do
    it "should return true when i try to find exist string" do
      @ie.frame(:id, "first_frame").contains_text("button").should be_true
    end

    it "should return true when i try to find exist regexp" do
      @ie.frame(:id, "first_frame").contains_text(/button/).should be_true
    end

    it "should return false when i try to find not exist string" do
      @ie.frame(:id, "first_frame").contains_text("not exist").should be_false
    end

    it "should return false when i try to find not exist regexp" do
      @ie.frame(:id, "first_frame").contains_text(/not exist/).should be_false
    end

    it "should raise Argument error when i pass a nil object" do
      lambda { @ie.frame(:id, "first_frame").contains_text(nil) }.should raise_error(ArgumentError)
    end

    it "should raise Argument error when i pass number" do
      lambda { @ie.frame(:id, "first_frame").contains_text(1) }.should raise_error(ArgumentError)
    end

    it "should raise Argument error when i pass class" do
      class A
      end
      lambda { @ie.frame(:id, "first_frame").contains_text(A.new) }.should raise_error(ArgumentError)
    end
  end
end