require 'watir/element'
module Watir
  class Element
    def top_center
      assert_exists
      assert_enabled
      h = (ole_object.height.to_i/2 rescue 0)
      ole_object.getBoundingClientRect.top.to_i + h
    end

    def top_center_absolute
      top_center + page_container.document.parentWindow.screenTop.to_i
    end

    def left_center
      assert_exists
      assert_enabled
      w = (ole_object.width.to_i/2 rescue 0)
      ole_object.getBoundingClientRect.left.to_i + w
    end

    def left_center_absolute
      left_center + page_container.document.parentWindow.screenLeft.to_i
    end

    def right_click
      x = left_center_absolute
      y = top_center_absolute
      # puts "x: #{x}, y: #{y}"
      WindowsInput.move_mouse(x, y)
      WindowsInput.right_click
    end

    def left_click
      x = left_center_absolute
      y = top_center_absolute
      puts "x: #{x}, y: #{y}"
      # need some extra push to get the cursor in the right area
      WindowsInput.move_mouse(x + 2, y + 2)
      WindowsInput.left_click
    end
  end
end