# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/recurring/managed_recurring_indian_card_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::ManagedRecurringIndianCardAttributes do
  let(:managed_recurring) do
    GenesisSpec::Stubs::Api::Requests::Financial::Cards::Recurring::ManagedRecurringIndianCardAttributesStub.new
  end

  describe 'when managed_recurring_payment_type' do
    let(:payment_type) do
      GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::PaymentTypes.all.sample
    end

    it 'with setter' do
      expect { managed_recurring.managed_recurring_payment_type = payment_type }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_payment_type = payment_type

      expect(managed_recurring.managed_recurring_payment_type).to eq payment_type
    end
  end

  describe 'when managed_recurring_amount_type' do
    let(:amount_type) do
      GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::AmountTypes.all.sample
    end

    it 'with setter' do
      expect { managed_recurring.managed_recurring_amount_type = amount_type }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_amount_type = amount_type

      expect(managed_recurring.managed_recurring_amount_type).to eq amount_type
    end
  end

  describe 'when managed_recurring_frequency' do
    let(:frequency) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Frequencies.all.sample }

    it 'with setter' do
      expect do
        managed_recurring.managed_recurring_frequency = frequency
      end.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_frequency = frequency

      expect(managed_recurring.managed_recurring_frequency).to eq frequency
    end
  end

  describe 'when managed_recurring_validated' do
    it 'with setter' do
      expect { managed_recurring.managed_recurring_validated = true }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_validated = validated = true

      expect(managed_recurring.managed_recurring_validated).to eq validated
    end
  end

  describe 'when managed_recurring_registration_reference_number' do
    let(:number) { Faker::Number.positive }

    it 'with getter' do
      managed_recurring.managed_recurring_registration_reference_number = number

      expect(managed_recurring.managed_recurring_registration_reference_number).to eq number
    end

    it 'with setter' do
      expect { managed_recurring.managed_recurring_registration_reference_number = number }.to_not raise_error
    end
  end

  describe 'when managed_recurring_max_amount' do
    let(:decimal) { Faker::Number.decimal }

    it 'with getter' do
      managed_recurring.managed_recurring_max_amount = decimal

      expect(managed_recurring.managed_recurring_max_amount).to eq decimal
    end

    it 'with setter' do
      expect { managed_recurring.managed_recurring_max_amount = decimal }.to_not raise_error
    end
  end

  describe 'with managed_recurring_indian_card_attributes_structure' do
    let(:managed_recurring_structure) do
      {
        amount_type:                   nil,
        frequency:                     nil,
        max_amount:                    nil,
        payment_type:                  nil,
        registration_reference_number: nil,
        validated:                     nil
      }
    end

    it 'without values' do
      expect(managed_recurring.managed_recurring_indian_card_attributes_structure).to eq(managed_recurring_structure)
    end

    it 'with currency and without max amount' do
      managed_recurring.currency = 'EUR'

      expect(managed_recurring.managed_recurring_indian_card_attributes_structure).to eq(managed_recurring_structure)
    end

    it 'with currency with valid max amount' do
      managed_recurring.currency                     = 'EUR'
      managed_recurring.managed_recurring_max_amount = 0.99
      managed_recurring_structure[:max_amount]       = '99'

      expect(managed_recurring.managed_recurring_indian_card_attributes_structure).to eq(managed_recurring_structure)
    end

    it 'with currency with invalid max amount' do
      managed_recurring.currency                     = 'EUR'
      managed_recurring.managed_recurring_max_amount = 'invalid'

      expect { managed_recurring.managed_recurring_indian_card_attributes_structure }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid max amount without currency' do
      managed_recurring.currency                     = nil
      managed_recurring.managed_recurring_max_amount = 0.99

      expect { managed_recurring.managed_recurring_indian_card_attributes_structure }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
