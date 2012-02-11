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

    def click
      left_click
    end
  end
end