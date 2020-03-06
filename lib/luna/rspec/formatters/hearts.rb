# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require_relative "emoji"

module Luna
  module Formatters
    class Hearts < Emoji
      def example_passed(_)
        newline_or_addup
        output.print " ", success_color(
          "\u2764"
        )
      end

      def example_failed(_)
        newline_or_addup
        output.print " ", failure_color(
          "\u1F494"
        )
      end

      def example_pending(_)
        newline_or_addup
        output.print " ", pending_color(
          "\u2764"
        )
      end
    end

    register Hearts
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Hearts"
end
