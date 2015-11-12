require "rspec/core/formatters/base_text_formatter"
require "luna/rspec/formatters/profile"
require "rspec/version"

module Luna
  module RSpec
    module Formatters
      class Checks < ::RSpec::Core::Formatters::BaseTextFormatter
        include Profile

        if Gem::Version.new(::RSpec::Version::STRING) >= Gem::Version.new("3.0")
          then ::RSpec::Core::Formatters.register self, *[
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
            defined?(super) ? super(v) : \
              ::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        def allowed_cols
          @cols ||= (`tput cols 2>/dev/null || 80`.to_i / 1.6).floor
        end

        def start(*args)
          @lines = 0
          super(*args) if defined?(super)
          output.puts
        end

        def start_dump(*args)
          super(*args) if defined?(super)
          output.puts
        end

        def example_passed(e)
          super(e) if defined?(super)
          newline_or_addup
          output.print("\s")
          output.print(success_color("\u2714"))
        end

        def example_failed(e)
          super(e) if defined?(super)
          newline_or_addup
          output.print("\s")
          output.print(failure_color("\u2718"))
        end

        def example_pending(e)
          super(e) if defined?(super)
          newline_or_addup
          output.print("\s")
          output.print(pending_color("\u203D"))
        end

        private
        def newline_or_addup
          @lines == allowed_cols ? (output.puts; @lines = 1) : @lines+=1
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Checks"
end
