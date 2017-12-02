# Frozen-string-literal: true
# Copyright: 2012 - 2017 - MIT License
# Encoding: utf-8

require "rspec/helper"
describe Jekyll::Faker::Tag do
  let :args do
    "lorem sentences=3"
  end

  #

  before do
    @body, @init_ctx, @ctx = CtxBlockThief.steal_with \
      "<p>{{ faker.val }}</p>"
  end

  #

  subject do
    subj = described_class.new("faker", args, @init_ctx)
    subj.instance_variable_set(:@body, @body)
    subj.render(@ctx)
  end

  #

  it "works" do
    expect(fragment(subject).search("p").size).to eq 3
  end

  #

  context "w/ mixed" do
    let :args do
      "lorem sentences=1 paragraphs=1"
    end

    #

    it "works" do
      expect(fragment(subject).search("p").size).to eq 2
    end
  end

  #

  context "w/ bad faker" do
    let :args do
      "missing"
    end

    #

    it "raises" do
      expect { subject }.to raise_error(ArgumentError,
        %r!Invalid Faker!i)
    end
  end

  #

  context "w/ bad faker method" do
    let :args do
      "lorem missing=4"
    end

    #

    it "raises" do
      expect { subject }.to raise_error(ArgumentError,
        %r!Unknown Faker!i)
    end
  end

  #

  context "w/ an add name" do
    let :args do
      "id-number valid"
    end

    #

    it "works" do
      expect(fragment(subject).search("p").size).to eq 1
    end
  end
end
