# ----------------------------------------------------------------------------
# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - Apache v2.0 License
# Encoding: utf-8
# ----------------------------------------------------------------------------

require "luna/rspec/formatters/emoji"

module Luna
  module RSpec
    module Formatters
      class Hearts < Emoji
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
            "\u2764"
          )
        end

        # --------------------------------------------------------------------

        def example_failed(e)
          newline_or_addup
          output.print " ".freeze, failure_color(
            "\u1F494"
          )
        end

        # --------------------------------------------------------------------

        def example_pending(e)
          newline_or_addup
          output.print " ".freeze, pending_color(
            "\u2764"
          )
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Hearts"
end
