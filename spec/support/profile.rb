# Frozen-string-literal: true
# Copyright: 2012 - 2017 - Jordon Bedwell - MIT License
# This file is taken from EnvyGeeks jekyll-rspec.
# Encoding: utf-8

unless ENV["CI"] == "true"
  RSpec.configure do |c|
    c.profile_examples = true
  end
end
