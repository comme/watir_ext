#coding: utf-8
require File.join(__FILE__, '..', '..', 'spec_helper')
describe Watir::FileField do
  before :each do
    @ie = Watir::IE.start(WatirExtHelper.html_page_path("fileupload.html"))
  end

  it "should success upload file" do
    file_field = @ie.file_field(:name, "file1")
    file_field.set(__FILE__)
    File.basename(file_field.value).should eq(File.basename(__FILE__))
  end

  after :each do
    @ie.close
  end
end