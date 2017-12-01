# Frozen-string-literal: true
# Copyright: 2012 - 2017 - Jordon Bedwell - MIT License
# This file is taken from EnvyGeeks jekyll-rspec.
# Encoding: utf-8

require "forwardable/extended"
require "nokogiri"

module Helpers
  # --
  # @param [string] html the HTML string.
  # Take in an HTML fragment and push out an object.
  # @return Nokogiri::HTML::Document
  # --
  def fragment(html)
    Nokogiri::HTML.fragment(html)
  end

  # --
  # @return [Object] whatever you yield.
  # @note this is useful for Jekyll builds.
  # Silence $stdout, and $stderr.
  # --
  def self.silence_stdout
    stdout, stderr = $stdout, $stderr
    $stdout = StringIO.new
    $stderr = StringIO.new

    yield
  ensure
    $stdout = stdout
    $stderr = stderr
  end

  # --
  def self.cleanup_trash
    Pathutil.new(fixture_path).join("_site").rm_rf
    %w(.jekyll-metadata .sass-cache .jekyll-cache).each do |v|
      Pathutil.pwd.join(v).rm_rf
    end
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.extend  Helpers
end
