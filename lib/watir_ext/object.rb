module Watir
  module Container
    def object(how, what=nil)
      Object.new(self, how, what)
    end
  end
  class Object < Element

    attr_accessor :retry_times
    def initialize(container, how, what)
      set_container container
      @how  = how
      @what = what
      @retry_times = 10
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
描述: 使用鼠标左键点击元素，如果传入popup=true,则会尝试重试制定次数直到有新的窗口产生
      当popup为true时: ATT::WindowNotFoundError--没有发现窗口
                       ATT::MutliWindowsMatchError--发现的窗口数大于一个
=end
    def left_click(popup=false)
      if popup
        times = @retry_times
        begin
          ATT::Popup.record
          super()
          ATT::Popup.find
        rescue ATT::WindowNotFoundError
          if times > 0
            times -= 1
            sleep 1
            retry
          end
          raise
        end
      else
        super()
      end
    end
  end
end