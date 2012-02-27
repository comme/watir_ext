#coding: utf-8
require 'watir/element'
module Watir
  class Element
    def top_center
      assert_exists
      assert_enabled
      t = ole_object.getBoundingClientRect.top.to_i
      b = ole_object.getBoundingClientRect.bottom.to_i
      t + (b - t)/2
    end

    def top_center_absolute
      top_center + page_container.document.parentWindow.screenTop.to_i
    end

    def left_center
      assert_exists
      assert_enabled
      l = ole_object.getBoundingClientRect.left.to_i
      r = ole_object.getBoundingClientRect.right.to_i
      l + (r - l)/2
    end

    def left_center_absolute
      left_center + page_container.document.parentWindow.screenLeft.to_i
    end

    def right_click(ox=0, oy=0)
      view
      x = left_center_absolute - scrollleft
      y = top_center_absolute - scrollheight
      puts "x: #{x}, y: #{y}"
      if view?(x, y)
        WindowsInput.move_mouse(x + ox.to_i, y + oy.to_i)
        WindowsInput.right_click
      else
        puts "判断元素不可见,其坐标为x:#{x},y:#{y},不再点击"
      end
    end

    def left_click(ox=0, oy=0)
      view
      x = left_center_absolute - scrollleft
      y = top_center_absolute - scrollheight
      puts "x: #{x}, y: #{y}"
      if view?(x, y)
        WindowsInput.move_mouse(x + 2 + ox.to_i, y + 2 + oy.to_i)
        WindowsInput.left_click
      else
        puts "判断元素不可见,其坐标为x:#{x},y:#{y},不再点击"
      end
    end

    def has_parent?
      me     = page_container.document.parentWindow
      parent = me.parent
      if parent.document.documentElement.scrollTop == me.document.documentElement.scrollTop
        false
      else
        true
      end
    end

    def scrollleft
      if has_parent?
        window     = page_container.document.parentWindow.parent || page_container.document.parentWindow
        true_width = window.document.body.scrollwidth
        view_width = window.document.body.offsetwidth
        true_width - view_width
      else
        0
      end
    end

    def scrollheight
      if has_parent?
        window = page_container.document.parentWindow.parent || page_container.document.parentWindow
        window.document.documentElement.scrollTop
      else
        0
      end
    end

    def relocate_parent_window
      window  = page_container.document.parentWindow
      yoffset = -window.screenTop.to_i
      offset  = (window.screen.availHeight.to_i/2 rescue 0)
      page_container.document.parentWindow.moveto(0, yoffset+offset)
    end

    def view
      assert_exists
      assert_enabled
      ole_object.scrollintoview(false)
    end

    def view?(x, y)
      width  = page_container.document.parentWindow.screen.availWidth
      height = page_container.document.parentWindow.screen.availHeight
      if x < 0 || x > width || y < 0 || y > height
        false
      else
        true
      end
    end

  end
end