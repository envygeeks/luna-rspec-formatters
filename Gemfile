source "https://rubygems.org"
gemspec

group :development do
  unless ENV["CI"]
    gem "pry"
  end

  gem "rake"
end

group :test do
  case ENV["RSPEC_VERSION"]
    when "stable" then gem "rspec", "~> 2.14"
    when "beta"   then gem "rspec", "~> 3.0.0.beta1"
  end
end
