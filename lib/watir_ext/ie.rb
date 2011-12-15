#coding:utf-8
require 'watir/windowhelper'
require 'timeout'
#module WatirExt
  module Watir
    class IE
      @@wait_time    = 60
      @@wait_timeout = false

      class << self
        def clickAlert()
          prompt_message = "您与该站点交换的信息不会被其它人查看或更改"
          window_title   = "安全警报"
          auotit         = WIN32OLE.new("AutoItX3.Control")
          sleep 1
          waitresult = auotit.WinWaitActive(window_title, prompt_message, @@wait_time)
          sleep 1
          if waitresult == 1
            auotit.ControlClick(window_title, prompt_message, "Button1")
            @@wait_timeout = false
          else
            @@wait_timeout = true
          end
        end

        def https_thread()
          WindowHelper.check_autoit_installed
          prompt_message = "您与该站点交换的信息不会被其它人查看或更改"
          title          = "安全警报"
          button         = "Button1"
          begin
            thrd = Thread.new do
              system("rubyw -e \"require 'win32ole'; @autoit=WIN32OLE.new('AutoItX3.Control'); waitresult=@autoit.WinWait '#{title}', '', 60; sleep 1; if waitresult == 1\" -e \"@autoit.ControlClick '#{title}', '#{prompt_message}', '#{button}';\" -e \"end\"")
            end
            thrd.join(1)
          rescue
            raise Watir::Exception::WatirException, "Problem confirm"
          end
          yield
        end

        def startAlertClicker()
          Thread.new() do
            check_alert_popups()
          end
        end

        def check_alert_popups()
          wait      = 120
          a_monment = 0.3
          title     = "安全警报"
          clicked   = false
          times     = 0
          autoit    = WIN32OLE.new("autoitx3.control")
          begin
            Timeout.timeout(wait, AutoTest::Exception::TimeoutError) do
              loop do
                if autoit.WinExists(title) == 1
                  WatirExt::Log.log("winexists == 1")
                  autoit.WinActivate(title)
                  autoit.ControlFocus(title, "", "Button1")
                  sleep a_monment
                  autoit.ControlClick(title, "", "Button1")
                  clicked = true
                  times   = 0
                end
                sleep 2
                times += 1 if clicked
                return if times > 3
              end
            end
          rescue
            ATT::KeyLog.info($!)
          end
        end

        def check_ie_version(ie)
          n = ie.document.invoke('parentWindow').navigator.appVersion
          m =/MSIE\s(.*?);/.match(n)

          if m and m[1] == '8.0'
            '8.0'
          elsif m and m[1] == '7.0'
            '7.0'
          elsif m and m[1] == '6.0'
            '6.0'
          else
            raise ArgumentError, 'unknown'
          end
        end

        def mystart(url)
          begin
            Timeout.timeout(5*60) do
              ie = Watir::IE.new()
              $IEVERSION = check_ie_version(ie) unless $IEVERSION
              startAlertClicker() if $IEVERSION == '6.0' and url.include?("https")
              ie.goto(url)
              ie.link(:id, "overridelink").click rescue true
              ie
            end
          rescue TimeoutError
            WatirExt::Log.log("fail open page #{url},timeout out 5 min")
            raise AutoTest::Exception::TimeoutError, "打开网页超时"
          end
        end

      end

      def contains_text(target)
        WatirExt::Log.log("my contains_text")
        flag = false
        begin
          if target.kind_of? Regexp
            flag = self.text.match(target)
          elsif target.kind_of? String
            flag = self.text.index(target)
          else
            raise ArgumentError, "Argument #{target} should be a string or regexp."
          end
          return flag if flag
          doc = self.document
          doc.frames.length.times do |m|
            begin
              frameObj = self.frame(:index, m+1)
            rescue => e
              WatirExt::Log.log "aa #{e}"
              break
            end
            if frameObj.contains_text(target)
              flag = true
              break
            end
          end
        rescue
        end
        return flag
      end
    end
  end
#end