# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - MIT License
# Encoding: utf-8

require "rspec/core/formatters/base_text_formatter"
require "luna/rspec/formatters/profile"
require "rspec/version"
require "coderay"

module Luna
  module RSpec
    module Formatters
      class Documentation < ::RSpec::Core::Formatters::BaseTextFormatter
        include Profile

        if Gem::Version.new(::RSpec::Version::STRING) >= Gem::Version.new("3.0")
          then Object::RSpec::Core::Formatters.register self, *[
            :start,
            :start_dump,
            :example_passed,
            :example_pending,
            :example_failed,
            :dump_profile
          ]
        end

        # --
        [:success, :failure, :pending].each do |m|
          define_method "#{m}_color" do |v|
            defined?(super) ? super(v) : ::RSpec::Core::Formatters::ConsoleCodes.wrap(
              v, m
            )
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
          print_description(
            get_example(struct), :success
          )
        end

        # --
        # Failed.
        # --
        def example_failed(struct)
          output.print "\s"
          print_description(
            get_example(struct), :failure
          )
        end

        # --
        # Pending.
        # --
        def example_pending(struct)
          output.print "\s"
          print_description(
            get_example(struct), :pending
          )
        end

        # --
        # Pull.
        # --
        def get_example(struct)
          return struct unless struct.respond_to?(:example)
          struct.example
        end

        # --
        # Description.
        # --
        def print_description(example, type)
          output.print send(
            :"#{type}_color", "  " + example.full_description + "\n"
          )
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Documentation"
end
