# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/account_owner_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::AccountOwnerAttributes do
  let(:account_owner) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::AccountOwnerAttributesStub.new }

  describe 'when first name' do
    it 'with valid value' do
      expect do
        account_owner.account_first_name = Faker::Name.first_name[0..described_class::ACCOUNT_NAME_LENGTH]
      end.to_not raise_error
    end

    it 'with invalid value' do
      expect do
        account_owner.account_first_name = Faker::String.random length: described_class::ACCOUNT_NAME_LENGTH + 1
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      account_owner.account_first_name = first_name = Faker::Name.first_name[0..described_class::ACCOUNT_NAME_LENGTH]

      expect(account_owner.account_first_name).to eq first_name
    end
  end

  describe 'when middle name' do
    it 'with valid value' do
      expect do
        account_owner.account_middle_name = Faker::Name.middle_name[0..described_class::ACCOUNT_NAME_LENGTH]
      end.to_not raise_error
    end

    it 'with invalid value' do
      expect do
        account_owner.account_middle_name = Faker::String.random length: described_class::ACCOUNT_NAME_LENGTH + 1
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      account_owner.account_middle_name = middle_name = Faker::Name.middle_name[0..described_class::ACCOUNT_NAME_LENGTH]

      expect(account_owner.account_middle_name).to eq middle_name
    end
  end

  describe 'when last name' do
    it 'with valid value' do
      expect do
        account_owner.account_last_name = Faker::Name.last_name[0..described_class::ACCOUNT_NAME_LENGTH]
      end.to_not raise_error
    end

    it 'with invalid value' do
      expect do
        account_owner.account_last_name = Faker::String.random length: described_class::ACCOUNT_NAME_LENGTH + 1
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      account_owner.account_last_name = last_name = Faker::Name.last_name[0..described_class::ACCOUNT_NAME_LENGTH]

      expect(account_owner.account_last_name).to eq last_name
    end
  end

  describe 'when structure' do
    it 'with proper return type' do
      expect(account_owner.account_owner_attributes_structure).to be_kind_of Hash
    end

    it 'with non empty return value' do
      expect(account_owner.account_owner_attributes_structure).to_not be_empty
    end
  end
end
