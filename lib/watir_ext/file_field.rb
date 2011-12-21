#coding:utf-8
#module WatirExt
module Watir
  class FileField < InputElement
    #INPUT_TYPES = ["file"]
    #POPUP_TITLES = ['Choose file', 'Choose File to Upload']

    # set the file location in the Choose file dialog in a new process
    # will raise a Watir Exception if AutoIt is not correctly installed
#    def set(path_to_file, title)
#      if title!=nil
#        POPUP_TITLES<<title
#      end
#      assert_exists
#      require 'watir/windowhelper'
#      WindowHelper.check_autoit_installed
#      begin
#        Thread.new do
#          sleep 1 # it takes some time for popup to appear
#
#          system %{ruby -e '
#              require "win32ole"
#
#              @autoit = WIN32OLE.new("AutoItX3.Control")
#              time    = Time.now
#
#              while (Time.now - time) < 15 # the loop will wait up to 15 seconds for popup to appear
#                #{POPUP_TITLES.inspect}.each do |popup_title|
#                  next unless @autoit.WinWait(popup_title, "", 1) == 1
#
#                  @autoit.ControlSetText(popup_title, "", "Edit1", #{path_to_file.inspect})
#                  @autoit.ControlSend(popup_title, "", "Button2", "{ENTER}")
#                  exit
#                end # each
#              end # while
#          '}
#        end.join(1)
#      rescue
#        raise Watir::Exception::WatirException, "Problem accessing Choose file dialog"
#      end
#      click
#    end
    def set(path_to_file)
      ATT::FilePopup.record
      click_no_wait
      file_upload_window = ATT::FilePopup.find
      file_upload_window.set(path_to_file)
    end
  end
end
#end