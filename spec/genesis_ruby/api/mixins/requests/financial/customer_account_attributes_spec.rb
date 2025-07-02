# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/customer_account_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::CustomerAccountAttributes do
  let(:customer_account_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::CustomerAccountAttributesStub.new }

  describe 'when customer_account_id accessors' do
    it 'with setter' do
      expect do
        customer_account_attributes.customer_account_id = Faker::Lorem.characters(number: 20)
      end.to_not raise_error
    end

    it 'with getter' do
      customer_account_attributes.customer_account_id = id = Faker::Lorem.characters(number: 20)

      expect(customer_account_attributes.customer_account_id).to eq(id)
    end
  end

  describe 'when customer_account_id validations' do
    it 'with invalid value' do
      expect do
        customer_account_attributes.customer_account_id = Faker::Lorem.characters(number: 30)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      expect do
        customer_account_attributes.customer_account_id = Faker::Lorem.characters(number: 20)
      end.to_not raise_error
    end

    it 'with nil value' do
      expect do
        customer_account_attributes.customer_account_id = nil
      end.to_not raise_error
    end
  end
end
