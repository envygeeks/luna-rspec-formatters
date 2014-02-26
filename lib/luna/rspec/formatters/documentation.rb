require_relative "base"
require "coderay"

module Luna
  module RSpec
    module Formatters
      class Documentation < Base

        def example_passed(e)
          super(e)
          print_description(e, :success)
        end

        def example_failed(e)
          super(e)
          print_description(e, :failure)
        end

        def example_pending(e)
          super(e)
          print_description(e, :pending)
        end

        # -------------------------------------------------------------

        def print_description(example, type)
          output.print send(:"#{type}_color", "\t" + example.full_description + "\n")
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Documentation"
end
