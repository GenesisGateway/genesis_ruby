require 'spec/genesis_ruby/stubs/api/requests/financial/online_banking_payments/virtual_payment_address_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::OnlineBankingPayments::VirtualPaymentAddressAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::OnlineBankingPayments::VirtualPaymentAddressAttributesStub.new
  end

  it 'with getter' do
    attributes.virtual_payment_address = 'someone@bank'

    expect(attributes.virtual_payment_address).to eq 'someone@bank'
  end

  it 'with invalid virtual payment address' do
    expect { attributes.virtual_payment_address = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
  end
end
