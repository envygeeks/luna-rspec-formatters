require_relative "shared/base"
require "coderay"

module Luna
  module RSpec
    module Formatters
      class Documentation < Base

        def example_passed
          super(e)
          blank_line?
          success_color(print_description(e))
        end

        def example_failed
          super(e)
          blank_line?
          failed_color(print_description(e))
        end

        def example_pending
          super(e)
          blank_line?
          pending_color(print_description(e))
        end

        # -------------------------------------------------------------

        def highlight_graves(text)
          text.gsub(/`([^`]+)`/) { syntax_highlight($1) }
        end

        def syntax_highlight(text)
          CodeRay.scan(text, :ruby).term
        end


        def highlight_methods(text)
          text.gsub(/(#|\.)([a-z0-9_]+)/) { $1.white + $2.magenta }
        end

        # -------------------------------------------------------------

        def print_description(example)
          constant = example.full_description.chomp(example.description)
          output.print "  " + highlight_methods(syntax_highlight(constant))
          output.print highlight_graves(example.description) + ":"
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Documentation"
end
