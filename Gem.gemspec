require File.expand_path("../lib/luna/rspec/formatters/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.homepage = "https://github.com/envygeeks/luna-rspec-formatters"
  spec.description = "A couple of RSpec formatters."
  spec.version = Luna::Rspec::Formatters::VERSION
  spec.email = ["envygeeks@gmail.com"]
  spec.name = "luna-rspec-formatters"
  spec.authors = ["Jordon Bedwell"]
  spec.license = "Apache 2.0"
  spec.add_dependency "rspec"
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rake"
  spec.files = Dir["lib/**/*.rb"] + %W(License Readme.md Gemfile)
  spec.summary = "A couple of RSpec formatters the way I like them."
end
