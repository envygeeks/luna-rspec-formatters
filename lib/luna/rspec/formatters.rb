# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require "rspec"

module Luna
  module Formatters
    ConsoleCodes = RSpec::Core::Formatters::ConsoleCodes
    def self.register(name)
      RSpec::Core::Formatters.register(
        name, :start, :start_dump, :example_passed,
        :example_pending, :example_failed,
        :dump_profile
      )
    end
  end
end

# Default formatter.  I prefer this.
require_relative "formatters/checks"
