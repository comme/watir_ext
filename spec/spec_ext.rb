require 'rspec'
module RSpec
  module Core
    class Metadata < Hash
      module MetadataHash
        private
        def build_description_from(*parts)
          parts.map { |p| p.to_s }.inject do |desc, p|
            p =~ /^(#|::|\.)/ ? "#{desc}#{p}" : "#{desc} #{p}"
          end || ""
        end
      end
    end
  end
end
#class Array
#  alias reduce inject
#end