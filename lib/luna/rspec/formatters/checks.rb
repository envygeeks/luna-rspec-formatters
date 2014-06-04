require "rspec/core/formatters/base_text_formatter"
require "rspec/version"

module Luna
  module RSpec
    module Formatters
      class Checks < ::RSpec::Core::Formatters::BaseTextFormatter
        if ::RSpec::Version::STRING >= "3.0.0"
          # Probably not available in the old version of RSpec.
          ::RSpec::Core::Formatters.register self, :start, :start_dump, \
            :example_passed, :example_pending, :example_failed
        end

        # ---------------------------------------------------------------------

        [:success, :failure, :pending].each do |m|
          define_method "#{m}_color" do |v|
            defined?(super) ? super(v) : \
              ::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        # ---------------------------------------------------------------------

        def start(*args)
          super(*args) if defined?(super)
          output.puts
        end

        # ---------------------------------------------------------------------

        def start_dump(*args)
          super(*args) if defined?(super)
          output.puts
        end

        # ---------------------------------------------------------------------

        def example_passed(e)
          super(e) if defined?(super)
          output.print("\s")
          output.print(success_color("\u2713"))
        end

        # ---------------------------------------------------------------------

        def example_failed(e)
          super(e) if defined?(super)
          output.print("\s")
          output.print(failure_color("\u2718"))
        end

        # ---------------------------------------------------------------------

        def example_pending(e)
          super(e) if defined?(super)
          output.print("\s")
          output.print(pending_color("\u203D"))
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Checks"
end
