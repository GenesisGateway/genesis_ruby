# frozen_string_literal: true

require 'genesis_ruby'
require 'genesis_ruby/api/constants/non_financial/alternatives/alipay/site_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes do
  include_examples 'common constants examples', described_class::WEB

  it 'is defined after requiring the SDK' do
    expect(Object.const_defined?('GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes'))
      .to eq(true)
  end

  it 'defines exactly the WEB and APP constants' do
    expect(described_class.constants(false)).to match_array %i[WEB APP]
  end

  it 'returns all site types sorted' do
    expect(described_class.all).to eq %w(APP WEB)
  end

  %w(WEB APP).each do |value|
    it "accepts #{value} in strict mode" do
      expect(described_class.valid?(value, strict: true)).to eq(true)
    end
  end

  # A raised error fails the example, so each case also proves valid? does not raise
  ['web', 'Web', 'app', '', 'UNKNOWN', nil, 1].each do |value|
    it "rejects #{value.inspect} in strict mode without raising" do
      expect(described_class.valid?(value, strict: true)).to eq(false)
    end
  end
end
