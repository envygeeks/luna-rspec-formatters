# Frozen-String-Literal: true
# Copyright: 2015 - 2020 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require 'io/console'
require_relative '../formatters'
require 'rspec/core/formatters/base_text_formatter'
require_relative 'extras/profiling'

module Luna
  module Formatters
    class Emoji < RSpec::Core::Formatters::BaseTextFormatter
      include Profiling

      %i(success failure pending).each do |m|
        define_method "#{m}_color" do |v|
          return super(v) if defined?(super)
          Formatters::ConsoleCodes.wrap(v, m)
        end
      end

      # --
      # Note: If the terminal is too small
      # we just let it go. The total columns
      # we allow is just a example
      # --
      def allowed_cols
        return @allowed_cols if defined?(@allowed_cols)
        @allowed_cols ||= begin
          infi = Float::INFINITY
          size = IO.console&.winsize&.last
          size = size || infi
          size / 6
        end
      end

      def start(_)
        @lines = 0
        output.puts
      end

      def start_dump(_)
        output.puts
      end

      # --
      # Determine if we should start a new
      # line or keep on pushing out. Note: if
      # the terminal is too small we just let
      # it go until it's done.
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

    register Emoji
  end
end
