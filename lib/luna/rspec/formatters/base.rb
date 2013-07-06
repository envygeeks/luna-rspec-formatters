require 'rspec/core/formatters/base_text_formatter'
require 'term/ansicolor'
require 'coderay'
require 'libnotify'

# ----------------------------------------------------------------------------
# For backwards compatibility.
# ----------------------------------------------------------------------------

class String
  include Term::ANSIColor
end

# ----------------------------------------------------------------------------
# My RSpec formatters.
# ----------------------------------------------------------------------------

module Luna
  module RSpec
    module Formatters
      MethodMap = {
        :passed => ["\u2713", :green],
        :failed => ["\u2718", :red],
        :pending => ["\u203D", :yellow]
      }

      class Base < ::RSpec::Core::Formatters::BaseTextFormatter

        # --------------------------------------------------------------------
        # Outputs a blank line at the beginning of the marks.
        # --------------------------------------------------------------------

        def start(*args)
          super
          output.puts
        end

        # --------------------------------------------------------------------
        # Outputs a blank line at the end of the marks.
        # --------------------------------------------------------------------

        def start_dump
          super
          output.puts
        end

        # --------------------------------------------------------------------
        # Passes to super and then libnotify.
        # --------------------------------------------------------------------

        def dump_summary(duration, total, failures, pending)
          super; Libnotify.new do |notify|
            notify.summary = "RSpec Results"
            notify.urgency = :critical
            notify.timeout = 1
            notify.append = false
            notify.transient = true
            notify.body = "Passed: #{total - failures}, Failed: #{failures}"
          end.show!
        end
      end
    end
  end
end
