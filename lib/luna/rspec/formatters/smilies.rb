require "luna/rspec/formatters/emoji"

module Luna
  module RSpec
    module Formatters
      class Smilies < Emoji
        if Gem::Version.new(::RSpec::Version::STRING) >= Gem::Version.new("3.0")
          Object::RSpec::Core::Formatters.register self, *[
            :start,
            :start_dump,
            :example_passed,
            :example_pending,
            :example_failed,
            :dump_profile
          ]
        end

        # --------------------------------------------------------------------

        def example_passed(e)
          newline_or_addup
          output.print " ".freeze, success_color(
            "\u263A"
          )
        end

        # --------------------------------------------------------------------

        def example_failed(e)
          newline_or_addup
          output.print " ".freeze, failure_color(
            "\u2639"
          )
        end

        # --------------------------------------------------------------------

        def example_pending(e)
          newline_or_addup
          output.print " ".freeze, pending_color(
            "\u2639"
          )
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Smilies"
end