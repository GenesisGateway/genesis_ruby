RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::Boleto do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'BR'

    request
  end

  it 'when south american payment base class with proper kind' do
    expect(request).to be_kind_of GenesisRuby::Api::Requests::Base::Financials::SouthAmericanPayments
  end

  it 'when allowed billing countries with proper values' do
    expect(request.__send__(:allowed_billing_countries)).to eq %w(BR)
  end

  include_examples 'south american payment examples'
end
