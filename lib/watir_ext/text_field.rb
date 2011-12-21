#coding:utf-8
module Watir
  class TextField
    def characters_in(value, &blk)
      if RUBY_VERSION =~ /^1\.8/
        index = 0
        while index < value.length
          if WIN32OLE.codepage == WIN32OLE::CP_UTF8
            len = value[index] > 128 ? 3 : 1
          else
            len = value[index] > 128 ? 2 : 1
          end
          yield value[index, len]
          index += len
        end
      else
        value.each_char(&blk)
      end
    end
  end

end