require "luna/rspec/formatters/emoji"

module Luna
  module RSpec
    module Formatters
      class Smilies < Emoji
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

        def example_passed(e)
          newline_or_addup
          output.print " ".freeze, success_color(
            "\u1F63B"
          )
        end

        def example_failed(e)
          newline_or_addup
          output.print " ".freeze, failure_color(
            "\u1F63E"
          )
        end

        def example_pending(e)
          newline_or_addup
          output.print " ".freeze, pending_color(
            "\u1F63F"
          )
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Smilies"
end
