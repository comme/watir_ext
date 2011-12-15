#coding:utf-8
require File.join(__FILE__, '..', '..', 'spec_helper') if __FILE__ == $0
describe Watir::FileField do
  before :each do
    @ie = Watir::IE.start("http://localhost/fileupload.html")
  end
  it "should fail when i pass a invalid title" do
    file_field = @ie.file_field(:name, "file1")
    sleep 1 # it takes some time for popup to appear
    command = "start /b ruby #{File.join(__FILE__,'..','click_popup.rb')}"
    system(command)
    file_field.set(File.expand_path(__FILE__).gsub(/\//, '\\'), "invalid")
    File.basename(file_field.value).should_not eq(File.basename(__FILE__))
  end

  it "should success upload file" do
    file_field = @ie.file_field(:name, "file1")
    file_field.set(File.expand_path(__FILE__).gsub(/\//, '\\'), "选择要加载的文件")
    File.basename(file_field.value).should eq(File.basename(__FILE__))
  end

  after :each do
    @ie.close
  end
end