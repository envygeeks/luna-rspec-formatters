require_relative 'base'

module Luna
  module RSpec
    module Formatters
      class Checks < Base

        # --------------------------------------------------------------------
        # Checkmark, x and ?! with the colors green, red and yellow.
        # --------------------------------------------------------------------

        MethodMap.each do |m, u|
          define_method("example_#{m}") do |e|
            super(e)
            output.print " #{u.first}".send(u.last)
          end
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = 'Luna::RSpec::Formatters::Checks'
end
