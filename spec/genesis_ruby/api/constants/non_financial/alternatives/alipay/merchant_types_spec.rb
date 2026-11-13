# frozen_string_literal: true

require 'genesis_ruby'
require 'genesis_ruby/api/constants/non_financial/alternatives/alipay/merchant_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::MerchantTypes do
  include_examples 'common constants examples', described_class::INDIVIDUAL

  it 'is defined after requiring genesis_ruby' do
    expect(Object.const_defined?('GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::MerchantTypes'))
      .to eq true
  end

  it 'defines exactly the INDIVIDUAL and ENTERPRISE constants' do
    expect(described_class.constants(false)).to match_array %i[INDIVIDUAL ENTERPRISE]
  end

  it 'holds frozen uppercase String values' do
    described_class.constants(false).each do |name|
      value = described_class.const_get(name)

      expect([value.is_a?(String), value.frozen?, value == value.upcase]).to eq [true, true, true]
    end
  end

  it 'returns exactly INDIVIDUAL and ENTERPRISE from all' do
    expect(described_class.all).to match_array %w(INDIVIDUAL ENTERPRISE)
  end

  it 'returns no duplicates from all' do
    expect(described_class.all.uniq.size).to eq described_class.all.size
  end

  describe '.valid?' do
    %w(INDIVIDUAL ENTERPRISE).each do |value|
      it "returns true for #{value}" do
        expect(described_class.valid?(value, strict: true)).to eq true
      end
    end

    ['individual', 'enterprise', 'Enterprise', ' INDIVIDUAL', '', 'UNKNOWN', nil, :INDIVIDUAL].each do |value|
      it "does not raise for #{value.inspect}" do
        expect { described_class.valid?(value, strict: true) }.to_not raise_error
      end

      it "returns false for #{value.inspect}" do
        expect(described_class.valid?(value, strict: true)).to eq false
      end
    end
  end
end
