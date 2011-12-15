#coding:utf-8
module WatirExt
  class Log
    class <<self
      def log=(log)
        @@logger=log
      end
      def log(msg)
        send(@@logger.to_sym,msg)
      end
    end
  end
end