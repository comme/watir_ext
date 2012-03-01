module Watir
  module Container
    def object(how, what=nil)
      Object.new(self, how, what)
    end
  end
  class Object < Element

    def initialize(container, how, what)
      set_container container
      @how  = how
      @what = what
      super(nil)
    end

    def locate
      if @how == :xpath
        @o = @container.element_by_xpath(@what)
      else
        begin
          @o = @container.locate_tagged_element('object', @how, @what)
        rescue UnknownObjectException
          @o = nil
        end
      end
    end

=begin rdoc
描述: 使用鼠标左键点击元素，会尝试重试一次数直到有新的窗口产生
      有窗口产生时，返回一个ATT::Popup对象
      没有或者有多个窗口对象产生时，返回nil
=end
    def left_click(xoffset=0, yoffset=0)
      times = 2
      begin
        ATT::Popup.record
        super
        ATT::Popup.find
      rescue
        if times > 0
          times -= 1
          sleep 1
          retry
        end
        nil
      end
    end

    def left_click!(xoffset=0, yoffset=0)
      super
    end
  end
end