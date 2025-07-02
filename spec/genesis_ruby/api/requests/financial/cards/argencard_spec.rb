# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Argencard do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'AR'

    request
  end

  it 'when south american payment base class with proper kind' do
    expect(request).to be_kind_of GenesisRuby::Api::Requests::Base::Financials::SouthAmericanPayments
  end

  it 'when allowed billing countries with proper values' do
    expect(request.__send__(:allowed_billing_countries)).to eq %w(AR)
  end

  include_examples 'south american payment examples'
end
