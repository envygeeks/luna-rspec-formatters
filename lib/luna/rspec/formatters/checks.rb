# Frozen-string-literal: true
# Copyright: 2015 - 2020 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require_relative 'emoji'

module Luna
  module Formatters
    class Checks < Emoji
      def example_passed(_)
        newline_or_addup
        output.print ' ', success_color(
          "\u2714"
        )
      end

      def example_failed(_)
        newline_or_addup
        output.print ' ', failure_color(
          "\u2718"
        )
      end

      def example_pending(_)
        newline_or_addup
        output.print ' ', pending_color(
          "\u203D"
        )
      end
    end

    register Checks
  end
end

RSpec.configure do |c|
  c.formatter = 'Luna::Formatters::Checks'
end
