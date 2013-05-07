require_relative "shared/base"

module Luna
  module RSpec
    module Formatters
      class Checks < Shared::Base

        ###
        # Checkmark, x and ?! with the colors green, red and yellow.
        # @return [String] ANSI colored string.

        MethodMap.each do |m, u|
          define_method("example_#{m}") do |e|
            super(e)
            blank_line?
            output.print " #{u.first}".send(u.last)
          end
        end
      end
    end
  end
end
