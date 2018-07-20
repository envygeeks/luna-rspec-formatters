# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

require "forwardable/extended"
require "rspec"

module Luna
  module Formatters
    ConsoleCodes = RSpec::Core::Formatters::ConsoleCodes
    extend Forwardable::Extended
    rb_delegate :"self.register", {
      to: :"RSpec::Core::Formatters", alias_of: :register
    }

  end
end

# Default formatter.  I prefer this.
require_relative "formatters/checks"
