require 'spec/genesis_ruby/stubs/api/requests/financial/purpose_of_payment_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::PurposeOfPaymentAttributes do
  let(:purpose_of_payment_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::PurposeOfPaymentAttributesStub.new
  end

  describe 'when purpose_of_payment accessors' do
    it 'with setter' do
      expect do
        purpose_of_payment_attributes.purpose_of_payment =
          GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all.sample
      end.to_not raise_error
    end

    it 'with getter' do
      purpose_of_payment_attributes.purpose_of_payment = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all.sample
      expect(purpose_of_payment_attributes.purpose_of_payment).to eq(value)
    end
  end
end
