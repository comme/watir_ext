#coding: utf-8
module Watir
  class Element
    def assert_exists
      begin
        Watir::Waiter::wait_until(15) { exists? }
      rescue
        log "assert_exists fail: #{$!} "
      end
      locate if respond_to?(:locate)
      unless ole_object
        raise UnknownObjectException.new(
          Watir::Exception.message_for_unable_to_locate(@how, @what))
      end
    end
  end
end