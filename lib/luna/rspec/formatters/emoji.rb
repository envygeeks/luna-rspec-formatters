# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

require "io/console"
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
            return super(v) if defined?(super)
            Object::RSpec::Core::Formatters::ConsoleCodes.wrap(v, m)
          end
        end

        # --
        # Note: If the terminal is too small we just let it go.
        # The total columns we allow.
        # --
        def allowed_cols
          @cols ||= begin
            (val = IO.console.winsize.last / 4) >= 24 ? val.floor : Float::INFINITY
          end
        end

        # --
        # Start.
        # --
        def start(_)
          @lines = 0
          output.puts
        end

        # --
        # End.
        # --
        def start_dump(_)
          output.puts
        end

        # --
        # Determine if we should start a new line or keep on pushing out.
        # Note: if the terminal is too small we just let it go.
        # --
        private
        def newline_or_addup
          return @lines+= 1 unless @lines == allowed_cols
          output.puts; @lines = 1
        end
      end
    end
  end
end
