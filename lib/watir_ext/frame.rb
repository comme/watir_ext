#coding:utf-8
#module WatirExt
module Watir
  class Frame
    def contains_text(target)
      if target.kind_of? Regexp
        flag = self.text.match(target)
      elsif target.kind_of? String
        flag = self.text.index(target)
      else
        raise ArgumentError, "Argument #{target} should be a string or regexp."
      end

      if flag == false || flag == nil
        doc = self.document
        doc.frames.length.times do |m|
          begin
            frameObj = self.frame(:index, m+1)
          rescue => e
            puts "bb #{e}"
            break
          end
          if frameObj.contains_text(target)
            flag = true
            break
          end
        end
      end
      return flag
    end
  end
end
#end