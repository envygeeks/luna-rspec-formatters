require "rspec/core/formatters/base_text_formatter"
require "libnotify"

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
      class Base < ::RSpec::Core::Formatters::BaseTextFormatter
        def start(*args)
          super
          output.puts
        end

        def start_dump
          super
          output.puts
        end

        def dump_summary(duration, total, failures, pending)
        super
          Libnotify.new do |notify|
            notify.summary = "RSpec Test Results"
            notify.urgency = :critical
            notify.transient = true
            notify.append = true
            notify.timeout = 1
            notify.body = \
              "Passed: #{total - failures}, Failed: #{failures}, Pending: #{pending}"
          end.show!
        end
      end
    end
  end
end
