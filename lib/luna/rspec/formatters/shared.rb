require "rspec/core/formatters/base_text_formatter"
require "colorize"
require "coderay"

module Luna
  module RSpec
    module Formatters
      MethodMap = {
        :passed => ["\u2713", :green],
        :failed => ["\u2718", :red],
        :pending => ["\u203D", :yellow]
      }

      module Shared
        class Base < ::RSpec::Core::Formatters::BaseTextFormatter
          def initialize(*args)
            super(*args)
            @lunas_first_output = true
          end

          def start_dump
            super
            output.puts
          end

          def blank_line?
            if @lunas_first_output
              output.puts
              @lunas_first_output = false
            end
          end
        end
      end
    end
  end
end
