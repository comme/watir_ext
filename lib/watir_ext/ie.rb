#coding:utf-8
#require 'watir/windowhelper'
require 'timeout'
module Watir
  class IE
#    @@wait_time    = 60
#    @@wait_timeout = false

    class <<self
      def each
        shell = WIN32OLE.new('Shell.Application')
        shell.Windows.each do |window|
          next unless (window.path =~ /Internet Explorer/i rescue false)
          next unless (hwnd = window.hwnd rescue false)
          ie      = IE.bind(window)
          ie.hwnd = hwnd
          yield ie
        end
      end

      def record
        @@hwnds = []
        each do |ie|
          @@hwnds << ie.hwnd
        end
      end

      def attach_new
        Watir::IE.attach_timeout = 30
        raise ArgumentError, "please call method 'record' before call me" unless defined?(@@hwnds)
        begin
          Watir::until_with_timeout do
            each do |ie|
              unless @@hwnds.include?(ie.hwnd)
                @@hwnds << ie.hwnd
                ie.wait
                return ie
              end
            end
            nil
          end
        rescue Watir::TimeOutException
        end
        raise Watir::NoMatchingWindowFoundException, "cannot found a new ie window"
      end
    end

    def ie_version
      n = self.document.invoke('parentWindow').navigator.appVersion
      m =/MSIE\s(.*?);/.match(n)

      if m and m[1] == '8.0'
        '8.0'
      elsif m and m[1] == '7.0'
        '7.0'
      elsif m and m[1] == '6.0'
        '6.0'
      else
        log "ie version section is #{m[1]}" rescue nil
        raise ArgumentError, 'unknown'
      end
    end

    def terminate
#      `taskkill /F /T /PID #{process_id}`
#      begin
#        refresh
#      rescue WIN32OLERuntimeError
#        puts("terminate ie success")
#        log("terminate ie success")
#      else
#        return false
#      end
      wmi = WIN32OLE.connect("winmgmts://")
      ps  = wmi.ExecQuery("select * from win32_process")
      ps.each do |p|
        if p.name =~ /iexplore\.exe/i and p.handle.to_i == process_id.to_i and p.terminate == 0
          @closing = true
          return true
        end
      end
      return false
    rescue Exception => e
      log e
      raise
    end

    def contains_text(target)
      log(" my contains_text ")
      if target.kind_of? Regexp
        flag = self.text.match(target)
      elsif target.kind_of? String
        flag = self.text.index(target)
      else
        raise ArgumentError, " Argument #{target} should be a string or regexp."
      end

      return flag if flag
      doc = self.document
      doc.frames.length.times do |m|
        begin
          frameObj = self.frame(:index, m+1)
        rescue Exception => e
          log "occur exception: #{e.class},#{e.message}"
          break
        end
        if frameObj.contains_text(target)
          flag = true
          break
        end
      end
      return flag
    end

    def process_id
      Watir::IE::Process.process_id_from_hwnd self.hwnd
    end
  end
end