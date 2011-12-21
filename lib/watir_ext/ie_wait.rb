#coding:utf-8
require 'timeout'
module Watir
  class IE
    #有风险，并未改变ie的状态
    alias old_wait wait

    def wait(no_sleep=false)
      ret = 0
      begin
        Timeout.timeout(30) do
          ret = old_wait(no_sleep)
        end
      rescue Timeout::Error
        log "wait method timeout(30s),just go ahead"
      end
      ret
    end
  end
end