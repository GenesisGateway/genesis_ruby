# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/purpose_of_payment_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::PurposeOfPaymentAttributes do
  let(:purpose_of_payment_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::PurposeOfPaymentAttributesStub.new
  end

  describe 'when purpose_of_payment accessors' do
    it 'accepts and returns a Visa code' do
      purpose_of_payment_attributes.purpose_of_payment = 'ISBONU'

      expect(purpose_of_payment_attributes.purpose_of_payment).to eq('ISBONU')
    end

    it 'accepts and returns a Visa value' do
      purpose_of_payment_attributes.purpose_of_payment = 'bonus_payment'

      expect(purpose_of_payment_attributes.purpose_of_payment).to eq('bonus_payment')
    end

    it 'stores nil when set to nil' do
      purpose_of_payment_attributes.purpose_of_payment = nil

      expect(purpose_of_payment_attributes.purpose_of_payment).to be_nil
    end

    it 'stores nil when set to an empty string' do
      purpose_of_payment_attributes.purpose_of_payment = ''

      expect(purpose_of_payment_attributes.purpose_of_payment).to be_nil
    end

    it 'replaces an earlier value with nil when set to an empty string' do
      purpose_of_payment_attributes.purpose_of_payment = 'ISBONU'
      purpose_of_payment_attributes.purpose_of_payment = ''

      expect(purpose_of_payment_attributes.purpose_of_payment).to be_nil
    end
  end

  describe 'when invalid purpose_of_payment' do
    it 'raises InvalidArgumentError for a value outside the default list' do
      expect { purpose_of_payment_attributes.purpose_of_payment = 'crowd_lending' }
        .to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allowed_purpose_of_payment_values' do
    it 'matches the Visa codes and Visa values' do
      expected = GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all +
                 GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPaymentValues.all

      expect(purpose_of_payment_attributes.allowed_purpose_of_payment_values).to match_array(expected)
    end
  end
end
