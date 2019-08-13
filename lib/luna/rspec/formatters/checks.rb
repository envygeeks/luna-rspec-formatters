# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require_relative "emoji"

module Luna
  module Formatters
    class Checks < Emoji
      Formatters.register self, :start, :start_dump, :example_passed,
        :example_pending, :example_failed, :dump_profile

      # --
      # Passed.
      # --
      def example_passed(_)
        newline_or_addup
        output.print " ", success_color(
          "\u2714"
        )
      end

      # --
      # Failed.
      # --
      def example_failed(_)
        newline_or_addup
        output.print " ", failure_color(
          "\u2718"
        )
      end

      # --
      # Pending.
      # --
      def example_pending(_)
        newline_or_addup
        output.print " ", pending_color(
          "\u203D"
        )
      end
    end
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Checks"
end
