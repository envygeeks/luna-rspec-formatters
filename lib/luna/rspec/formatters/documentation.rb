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

      %i(success failure pending).each do |m|
        define_method "#{m}_color" do |v|
          return super(v) if defined?(super)
          RSpec::Core::Formatters::ConsoleCodes
            .wrap(v, m)
        end
      end

      def start(_)
        output.puts
      end

      def start_dump(_)
        output.puts
      end

      def example_passed(struct)
        output.print "\s"
        print_description(
          get_example(struct), :success
        )
      end

      def example_failed(struct)
        output.print "\s"
        print_description(
          get_example(struct), :failure
        )
      end

      def example_pending(struct)
        output.print "\s"
        print_description(
          get_example(struct), :pending
        )
      end

      def get_example(struct)
        return struct unless struct.respond_to?(:example)
        struct.example
      end

      def print_description(example, type)
        desc = example.full_description
        output.print send(
          :"#{type}_color", "  " + desc + "\n"
        )
      end
    end

    register Documentation
  end
end

RSpec.configure do |c|
  c.formatter = "Luna::Formatters::Documentation"
end
