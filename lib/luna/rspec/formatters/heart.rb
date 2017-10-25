# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

require_relative "emoji"

module Luna
  module Formatters
    class Hearts < Emoji
      Formatters.register self, :start, :start_dump, :example_passed,
        :example_pending, :example_failed, :dump_profile

      # --
      # Passed.
      # --
      def example_passed(_)
        newline_or_addup
        output.print " ".freeze, success_color(
          "\u2764"
        )
      end

      # --
      # Failed.
      # --
      def example_failed(_)
        newline_or_addup
        output.print " ".freeze, failure_color(
          "\u1F494"
        )
      end

      # --
      # Pending.
      # --
      def example_pending(_)
        newline_or_addup
        output.print " ".freeze, pending_color(
          "\u2764"
        )
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::Formatters::Hearts"
end
