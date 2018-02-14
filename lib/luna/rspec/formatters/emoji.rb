# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require "io/console"
require_relative "../formatters"
require "rspec/core/formatters/base_text_formatter"
require_relative "profiling"

module Luna
  module Formatters
    class Emoji < RSpec::Core::Formatters::BaseTextFormatter
      include Profiling

      # --
      %i(success failure pending).each do |m|
        define_method "#{m}_color" do |v|
          return super(v) if defined?(super)
          Formatters::ConsoleCodes.wrap(v, m)
        end
      end

      # --
      # Note: If the terminal is too small we just let it go.
      # The total columns we allow.
      # --
      def allowed_cols
        @cols ||= (IO.console.winsize.last / 6)
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
      # Determine if we should start a new line or keep
      # on pushing out. Note: if the terminal is too small
      # we just let it go.
      # --
      private
      def newline_or_addup
        unless @lines == allowed_cols
          return @lines += 1
        end

        output.puts
        @lines = 1
      end
    end
  end
end
