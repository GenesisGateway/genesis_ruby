# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/bank_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::BankAttributes do
  let(:bank_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::BankAttributesStub.new }

  describe 'when bic' do
    it 'with setter' do
      expect { bank_attributes.bic = Faker::Bank.swift_bic }.to_not raise_error
    end

    it 'with getter' do
      bank_attributes.bic = bic = Faker::Bank.swift_bic
      expect(bank_attributes.bic).to eq(bic)
    end

    it 'when validates with minimum letters length' do
      expect { bank_attributes.bic = Faker::Alphanumeric.alphanumeric(number: 3) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'when validates with maximum letters length' do
      expect { bank_attributes.bic = Faker::Alphanumeric.alphanumeric(number: 20) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

  end

  describe 'when iban' do
    it 'with setter' do
      expect { bank_attributes.iban = Faker::Bank.iban }.to_not raise_error
    end

    it 'with getter' do
      bank_attributes.iban = iban = Faker::Bank.iban
      expect(bank_attributes.iban).to eq(iban)
    end

    it 'with invalid iban value' do
      expect { bank_attributes.iban = Faker::Alphanumeric.alphanumeric(number: 40) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

  end
end
