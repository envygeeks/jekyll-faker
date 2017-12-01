# Frozen-string-literal: true
# Copyright: 2012 - 2017 - Jordon Bedwell - MIT License
# This file is taken from EnvyGeeks jekyll-rspec.
# Encoding: utf-8

module Shared
  extend RSpec::SharedContext
  subject do
    described_class
  end
end

RSpec.configure do |c|
  c.include Shared
end
