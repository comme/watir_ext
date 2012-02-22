require 'watir/element'
module Watir
  class Element
    def top_center
      assert_exists
      assert_enabled
      if (ole_object.height.to_s =~ /^\s*\d+\s*$/ rescue false)
        h = ole_object.height.to_i/2
      else
        h = 0
      end
      ole_object.getBoundingClientRect.top.to_i + h
    end

    def top_center_absolute
      puts "left_center:#{top_center}"
      puts "page_container.document.parentWindow.screenLeft:#{page_container.document.parentWindow.screenTop.to_i}"
      top_center + page_container.document.parentWindow.screenTop.to_i
    end

    def left_center
      assert_exists
      assert_enabled
      if (ole_object.width.to_s =~ /^\s*\d+\s*$/ rescue false)
        w = ole_object.width.to_i/2
      else
        w = 0
      end
      ole_object.getBoundingClientRect.left.to_i + w
    end

    def left_center_absolute
      puts "left_center:#{left_center}"
      puts "page_container.document.parentWindow.screenLeft:#{page_container.document.parentWindow.screenLeft.to_i}"
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
      relocate_parent_window
      view
      x = left_center_absolute
      y = top_center_absolute
      puts "x: #{x}, y: #{y}"
      WindowsInput.move_mouse(x + 2, y + 2)
      WindowsInput.left_click
    end

    def relocate_parent_window
      yoffset = -page_container.document.parentWindow.screenTop.to_i
      page_container.document.parentWindow.moveto(0,yoffset)
    end

    def view
      assert_exists
      assert_enabled
      ole_object.scrollintoview(false)
    end
  end
end