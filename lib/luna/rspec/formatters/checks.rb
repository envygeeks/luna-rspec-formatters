require_relative "base"

module Luna
  module RSpec
    module Formatters
      class Checks < Base
        def example_passed(e)
          super(e)
          output.print("\s")
          output.print(success_color("\u2713"))
        end

        def example_failed(e)
          super(e)
          output.print("\s")
          output.print(failure_color("\u2718"))
        end

        def example_pending(e)
          super(e)
          output.print("\s")
          output.print(pending_color("\u203D"))
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.formatter = "Luna::RSpec::Formatters::Checks"
end
