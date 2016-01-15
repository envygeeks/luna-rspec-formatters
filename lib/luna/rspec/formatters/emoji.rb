require "rspec/core/formatters/base_text_formatter"
require "luna/rspec/formatters/profile"
require "rspec/version"

module Luna
  module RSpec
    module Formatters
      class Emoji < ::RSpec::Core::Formatters::BaseTextFormatter
        include Profile

        [:success, :failure, :pending].each do |m|
          define_method "#{m}_color" do |v|
            defined?(super) ? super(v) : \
              ::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        # --------------------------------------------------------------------

        def allowed_cols
          @cols ||= begin
            (`tput cols 2>/dev/null || 80`.to_i / 1.6).floor
          end
        end

        # --------------------------------------------------------------------

        def start(*args)
          @lines = 0
          output.puts
        end

        # --------------------------------------------------------------------

        def start_dump(*args)
          output.puts
        end

        # --------------------------------------------------------------------

        private
        def newline_or_addup
          @lines == allowed_cols ? (output.puts; @lines = 1) : @lines+=1
        end
      end
    end
  end
end
