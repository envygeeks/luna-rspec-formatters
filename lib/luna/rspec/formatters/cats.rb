# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

require_relative "emoji"

module Luna
  module Formatters
    class Cats < Emoji
      Formatters.register self, :start, :start_dump, :example_passed,
        :example_pending, :example_failed, :dump_profile

      # --
      # Passed.
      # --
      def example_passed(_)
        newline_or_addup
        output.print " ",
          success_color("\u1F63B")
      end

      # --
      # Failed.
      # --
      def example_failed(_)
        newline_or_addup
        output.print " ",
          failure_color("\u1F63E")
      end

      # --
      # Pending.
      # --
      def example_pending(_)
        newline_or_addup
        output.print " ",
          pending_color("\u1F63F")
      end
    end
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Cats"
end
