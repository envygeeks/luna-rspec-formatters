# ----------------------------------------------------------------------------
# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - MIT License
# Encoding: utf-8
# ----------------------------------------------------------------------------

require "luna/rspec/formatters/emoji"

module Luna
  module RSpec
    module Formatters
      class Smilies < Emoji
        if Gem::Version.new(Object::RSpec::Version::STRING) >= Gem::Version.new("3.0")
          then Object::RSpec::Core::Formatters.register self, *[
            :start,
            :start_dump,
            :example_passed,
            :example_pending,
            :example_failed,
            :dump_profile
          ]
        end

        # --------------------------------------------------------------------
        # Passed.
        # --------------------------------------------------------------------

        def example_passed(_)
          newline_or_addup
          output.print " ".freeze, success_color(
            "\u1F63B"
          )
        end

        # --------------------------------------------------------------------
        # Failed.
        # --------------------------------------------------------------------

        def example_failed(_)
          newline_or_addup
          output.print " ".freeze, failure_color(
            "\u1F63E"
          )
        end

        # --------------------------------------------------------------------
        # Pending.
        # --------------------------------------------------------------------

        def example_pending(_)
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
