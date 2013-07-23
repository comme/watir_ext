#coding:utf-8
# 修正click_no_wait bug
require 'watir/page-container'
module Watir
  module PageContainer
    def eval_in_spawned_process(command)
      command.strip!
      load_path_code = _code_that_copies_readonly_array($LOAD_PATH, '$LOAD_PATH')
      ruby_code      = "require 'watir/ie'; "
      # ruby_code = "$HIDE_IE = #{$HIDE_IE};" # This prevents attaching to a window from setting it visible. However modal dialogs cannot be attached to when not visible.
      ruby_code << "pc = #{attach_command}; " # pc = page container
      # IDEA: consider changing this to not use instance_eval (it makes the code hard to understand)
      ruby_code << "pc.instance_eval(#{command.inspect})"
      exec_string = "start rubyw -e #{(load_path_code + '; ' + ruby_code).inspect}"
      # exec_string = "start rubyw -e #{(load_path_code + '; ' + ruby_code).gsub('"', '\'').inspect}"
      system(exec_string)
    end
  end
end