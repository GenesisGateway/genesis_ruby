require 'spec/genesis_ruby/stubs/api/requests/financial/payment_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::PaymentAttributes do
  let(:payment_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::PaymentAttributesStub.new(GenesisRuby::Configuration.new)
  end

  describe 'has proper amount accessors' do
    it 'has setter' do
      expect { payment_attributes.amount = Faker::Number.decimal(l_digits: 2, r_digits: 2) }.to_not raise_error
    end

    it 'has getter' do
      payment_attributes.amount = amount = Faker::Number.decimal(l_digits: 2, r_digits: 2)

      expect(payment_attributes.amount).to eq(amount)
    end
  end

  describe 'has proper currency accessors' do
    it 'has setter' do
      expect { payment_attributes.currency = Faker::Currency.code }.to_not raise_error
    end

    it 'can get currency' do
      payment_attributes.currency = currency = Faker::Currency.code

      expect(payment_attributes.currency).to eq(currency)
    end
  end

  it 'has hash payment_attributes_structure' do
    payment_attributes.amount   = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    payment_attributes.currency = 'EUR'

    expect(payment_attributes.payment_attributes_structure).to be_kind_of(Hash)
  end
end
