require "rspec/core/formatters/base_text_formatter"
require "rspec/version"
require "coderay"

module Luna
  module RSpec
    module Formatters
      class Documentation < ::RSpec::Core::Formatters::BaseTextFormatter
        if ::RSpec::Version::STRING >= "3.0.0"
          # Probably not available in the old version of RSpec.
          ::RSpec::Core::Formatters.register self, :start, :start_dump, \
            :example_passed, :example_pending, :example_failed
        end

        [:success, :failure, :pending].each do |m|
          define_method "#{m}_color" do |v|
            defined?(super) ? super(v) : \
              ::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        def start(*args)
          super(*args) if defined?(super)
          output.puts
        end

        def start_dump(*args)
          super(*args) if defined?(super)
          output.puts
        end

        def example_passed(e)
          output.print("\s")
          print_description(e, :success)
        end

        def example_failed(e)
          output.print("\s")
          print_description(e, :failure)
        end

        def example_pending(e)
          output.print("\s")
          print_description(e, :pending)
        end

        def print_description(example, type)
          output.print send(:"#{type}_color",
            "\t" + example.full_description + "\n")
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Documentation"
end
