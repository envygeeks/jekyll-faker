# Frozen-string-literal: true
# Copyright: 2012 - 2017 - Jordon Bedwell - MIT License
# This file is taken from EnvyGeeks jekyll-rspec.
# rubocop:disable Style/EmptyLineBetweenDefs
# rubocop:disable Style/SingleLineMethods
# Encoding: utf-8

class CtxBlockThief < Liquid::Block
  class << self; attr_accessor :ctx, :init_ctx, :body; end
  def parse(*args) super; self.class.body = @body; end
  def initialize(*args); super; self.class.init_ctx = args.last; end
  def render(ctx); super; self.class.ctx = ctx; end

  def self.steal_with(val)
    clas = Class.new(CtxBlockThief)
    name = SecureRandom.hex.gsub(%r!^\d+!, "")
    data = "{% #{name} %}#{val}{% end#{name} %}"
    Liquid::Template.register_tag name, clas
    Liquid::Template.parse(data).render({})

    [clas.body, clas.init_ctx, clas.ctx].tap do
      Liquid::Template.tags
        .delete(name)
    end
  end
end
