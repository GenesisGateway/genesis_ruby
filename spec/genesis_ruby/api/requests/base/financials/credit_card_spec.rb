require 'genesis_ruby/api/requests/base/financials/credit_card'
require 'spec/genesis_ruby/stubs/api/requests/base/financials/credit_card_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Financials::CreditCard do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

    configuration
  end

  let(:credit_card) do
    credit_card          = GenesisSpec::Stubs::Api::Requests::Base::Financials::CreditCardStub.new configuration
    credit_card.amount   = 1.99
    credit_card.currency = 'EUR'

    credit_card
  end

  it 'includes payment attributes' do
    expect(described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::PaymentAttributes)).to eq true
  end

  it 'includes tokenization attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Cards::TokenizationAttributes)
    ).to eq true
  end

  it 'includes credit card attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Cards::CreditCardAttributes)
    ).to eq true
  end

  it 'with payment transaction structure' do
    expect(credit_card.__send__(:payment_transaction_structure)).to be_kind_of Hash
  end
end
