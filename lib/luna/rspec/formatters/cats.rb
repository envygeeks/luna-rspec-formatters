# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require_relative "emoji"

module Luna
  module Formatters
    class Cats < Emoji
      def example_passed(_)
        newline_or_addup
        output.print " ", success_color(
          "\u1F63B"
        )
      end

      def example_failed(_)
        newline_or_addup
        output.print " ", failure_color(
          "\u1F63E"
        )
      end

      def example_pending(_)
        newline_or_addup
        output.print " ", pending_color(
          "\u1F63F"
        )
      end
    end

    register Cats
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Cats"
end
