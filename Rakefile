# Frozen-string-literal: true
# Copyright: 2012 - 2017 - MIT License
# Encoding: utf-8

# --
# 🔖
# RSpec, MiniTest, Whatever.
# --
task :spec do
  sh "script/test"
end
# --
# 🔖
# RSpec, MiniTest, Whatever.
# --
task :test do
  sh "script/test"
end
# --
# 🔖
# @see .rubocop.yml
# Rubocop.
# --
task :rubocop do
  sh "script/lint"
end
# --
# 🔖
# @see .rubocop.yml
# Rubocop.
# --
task :lint do
  sh "script/lint"
end

# --
Dir.glob("script/rake.d/*.rake").each do |v|
  load v
end
