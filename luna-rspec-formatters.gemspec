require File.expand_path("../lib/luna/rspec/formatters/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.homepage = "https://github.com/envygeeks/luna-rspec-formatters"
  spec.description = "RSpec formatters that are dedicated to Luna."
  spec.files = Dir["lib/**/*.rb"] + %W(License Readme.md Gemfile)
  spec.summary = "RSpec formatters dedicated to Luna."
  spec.version = Luna::Rspec::Formatters::VERSION
  spec.email = ["jordon@envygeeks.io"]
  spec.name = "luna-rspec-formatters"
  spec.authors = ["Jordon Bedwell"]
  spec.license = "Apache 2.0"
  spec.require_paths = ["lib"]

  spec.add_dependency("rspec", ">= 2.14", "< 4.0")
end
