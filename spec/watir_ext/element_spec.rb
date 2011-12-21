#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
require 'watir_ext/element'
describe Watir::Element do
  before "each" do
    @ie     = Watir::IE.new
    @button = @ie.button(:index, 1)
  end
  after "each" do
    @ie.close
  end
  it "should return true when i try to find textfield 1" do
    lambda {
      @ie.goto("#{WatirExtHelper.url_path}/hello")
      @button.click
    }.should_not raise_error
  end
  it "should not raise error when button appear time is 5 seconds" do
    lambda {
      @ie.goto("#{WatirExtHelper.url_path}/hello?time=5")
      @button.click
    }.should_not raise_error
  end
  it "should  raise error when button appear time is 16 seconds" do
    lambda {
      @ie.goto("#{WatirExtHelper.url_path}/hello?time=16")
      @button.click
    }.should raise_error(Watir::Exception::UnknownObjectException)
  end
end