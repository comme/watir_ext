module Watir
  module WindowsInput
  # Windows API functions
  SetCursorPos = Win32API.new('user32','SetCursorPos', 'II', 'I')
  SendInput = Win32API.new('user32','SendInput', 'IPI', 'I')
  # Autoit = WIN32OLE.new('autoitx3.control')
  # Windows API constants
  INPUT_MOUSE = 0
  MOUSEEVENTF_LEFTDOWN = 0x0002
  MOUSEEVENTF_LEFTUP = 0x0004
  MOUSEEVENTF_RIGHTDOWN = 0x0008
  MOUSEEVENTF_RIGHTUP = 0x0010

  module_function

  def send_input(inputs)
    n = inputs.size
    ptr = inputs.collect {|i| i.to_s}.join # flatten arrays into single string
    SendInput.call(n, ptr, inputs[0].size)
  end

  def create_mouse_input(mouse_flag)
    mi = Array.new(7, 0)
    mi[0] = INPUT_MOUSE
    mi[4] = mouse_flag
    mi.pack('LLLLLLL') # Pack array into a binary sequence usable to SendInput
  end

  def move_mouse(x, y)
    SetCursorPos.call(x, y)
  end

  def right_click
    rightdown = create_mouse_input(MOUSEEVENTF_RIGHTDOWN)
    rightup = create_mouse_input(MOUSEEVENTF_RIGHTUP)
    send_input( [rightdown, rightup] )
  end

  def left_click
    leftdown = create_mouse_input(MOUSEEVENTF_LEFTDOWN)
    leftup = create_mouse_input(MOUSEEVENTF_LEFTUP)
    send_input( [leftdown, leftup] )
	# puts "autoit click"
	# Autoit.MouseClick("left")
  end
end
end