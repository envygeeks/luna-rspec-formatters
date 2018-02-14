# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require_relative "profiling"
require "rspec/core/formatters/base_text_formatter"
require "rspec/version"

module Luna
  module Formatters
    class Documentation < RSpec::Core::Formatters::BaseTextFormatter
      include Profiling

      # --
      Formatters.register self, :start, :start_dump, :example_passed,
        :example_pending, :example_failed, :dump_profile

      # --
      %i(success failure pending).each do |m|
        define_method "#{m}_color" do |v|
          return super(v) if defined?(super)
          RSpec::Core::Formatters::ConsoleCodes
            .wrap(v, m)
        end
      end

      # --
      # Start.
      # --
      def start(_)
        output.puts
      end

      # --
      # End.
      # --
      def start_dump(_)
        output.puts
      end

      # --
      # Passed.
      # --
      def example_passed(struct)
        output.print "\s"
        print_description(get_example(struct),
          :success)
      end

      # --
      # Failed.
      # --
      def example_failed(struct)
        output.print "\s"
        print_description(get_example(struct),
          :failure)
      end

      # --
      # Pending.
      # --
      def example_pending(struct)
        output.print "\s"
        print_description(get_example(struct),
          :pending)
      end

      # --
      # Pull.
      # --
      def get_example(struct)
        unless struct.respond_to?(:example)
          return struct
        end

        struct.example
      end

      # --
      # Description.
      # --
      def print_description(example, type)
        output.print send(:"#{type}_color", "  " +
          example.full_description + "\n")
      end
    end
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Documentation"
end