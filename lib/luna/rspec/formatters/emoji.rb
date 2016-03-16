# ----------------------------------------------------------------------------
# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - MIT License
# Encoding: utf-8
# ----------------------------------------------------------------------------

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
            defined?(super) ? super(v) : Object::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        # --------------------------------------------------------------------

        def allowed_cols
          @cols ||= begin
            val = IO.console.winsize.last / 4
            val = Float::INFINITY unless val >= 24
            val = val.floor if val >= 24
            val
          end
        end

        # --------------------------------------------------------------------

        def start(_)
          @lines = 0
          output.puts
        end

        # --------------------------------------------------------------------

        def start_dump(_)
          output.puts
        end

        # --------------------------------------------------------------------

        private
        def newline_or_addup
          return @lines+= 1 unless @lines == allowed_cols
          output.puts; @lines = 1
        end
      end
    end
  end
end
