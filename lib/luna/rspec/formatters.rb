# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

require "rspec/core/formatters"
require "forwardable/extended"

module Luna
  module Formatters
    ConsoleCodes = RSpec::Core::Formatters::ConsoleCodes
    extend Forwardable::Extended
    rb_delegate :"self.register", {
      to: :"RSpec::Core::Formatters", alias_of: :register
    }
  end
end
