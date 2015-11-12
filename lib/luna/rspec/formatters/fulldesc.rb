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
          ::RSpec::Core::Formatters.register self, *[
            :start,
            :start_dump,
            :example_passed,
            :example_pending,
            :example_failed,
            :dump_profile
          ]
        end

        [:success, :failure, :pending].each do |m|
          define_method "#{m}_color" do |v|
            defined?(super) ? super(v) : ::RSpec::Core::Formatters::ConsoleCodes.wrap(
              v, m
            )
          end
        end

        def start(*args)
          output.puts
        end

        def start_dump(*args)
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