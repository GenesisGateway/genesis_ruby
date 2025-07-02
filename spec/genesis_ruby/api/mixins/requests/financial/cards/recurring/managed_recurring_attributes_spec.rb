# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/recurring/managed_recurring_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::ManagedRecurringAttributes do
  let(:managed_recurring) do
    GenesisSpec::Stubs::Api::Requests::Financial::Cards::Recurring::ManagedRecurringAttributesStub.new
  end

  it 'with managed recurring indian cards' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::
          ManagedRecurringIndianCardAttributes)
    ).to eq true
  end

  describe 'when managed_recurring_mode' do
    let(:mode) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Modes.all.sample }

    it 'with setter' do
      expect { managed_recurring.managed_recurring_mode = mode }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_mode = mode

      expect(managed_recurring.managed_recurring_mode).to eq mode
    end
  end

  describe 'when managed_recurring_interval' do
    let(:interval) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Intervals.all.sample }

    it 'with setter' do
      expect { managed_recurring.managed_recurring_interval = interval }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_interval = interval

      expect(managed_recurring.managed_recurring_interval).to eq interval
    end
  end

  describe 'when managed_recurring_first_date' do
    let(:timestamp) { Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats.all.sample }

    it 'with valid value' do
      expect { managed_recurring.managed_recurring_first_date = timestamp }.to_not raise_error
    end

    it 'with invalid value' do
      expect { managed_recurring.managed_recurring_first_date = 'invalid' }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      managed_recurring.managed_recurring_first_date = timestamp

      expect(managed_recurring.managed_recurring_first_date)
        .to eq DateTime.parse(timestamp).strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
    end
  end

  describe 'when managed_recurring_time_of_day' do
    let(:number) { Faker::Number.positive.to_i }

    it 'with setter' do
      expect { managed_recurring.managed_recurring_time_of_day = number }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_time_of_day = number

      expect(managed_recurring.managed_recurring_time_of_day).to eq number
    end

    it 'with string number' do
      managed_recurring.managed_recurring_time_of_day = number.to_s

      expect(managed_recurring.managed_recurring_time_of_day).to eq number
    end
  end

  describe 'when managed_recurring_period' do
    let(:number) { Faker::Number.positive.to_i }

    it 'with setter' do
      expect { managed_recurring.managed_recurring_period = number }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_period = number

      expect(managed_recurring.managed_recurring_period).to eq number
    end

    it 'with string number' do
      managed_recurring.managed_recurring_period = number.to_s

      expect(managed_recurring.managed_recurring_period).to eq number
    end
  end

  describe 'when managed_recurring_max_amount' do
    let(:amount) { Faker::Number.decimal }

    it 'with getter' do
      managed_recurring.managed_recurring_amount = amount

      expect(managed_recurring.managed_recurring_amount).to eq amount
    end

    it 'with setter' do
      expect { managed_recurring.managed_recurring_amount = amount }.to_not raise_error
    end
  end

  describe 'when managed_recurring_max_count' do
    let(:number) { Faker::Number.positive.to_i }

    it 'with setter' do
      expect { managed_recurring.managed_recurring_max_count = number }.to_not raise_error
    end

    it 'with getter' do
      managed_recurring.managed_recurring_max_count = number

      expect(managed_recurring.managed_recurring_max_count).to eq number
    end

    it 'with string number' do
      managed_recurring.managed_recurring_max_count = number.to_s

      expect(managed_recurring.managed_recurring_max_count).to eq number
    end
  end

  describe 'when managed_recurring_attributes_structure' do
    let(:managed_recurring_structure) do
      {
        amount:                        nil,
        amount_type:                   nil,
        first_date:                    nil,
        frequency:                     nil,
        interval:                      nil,
        max_amount:                    nil,
        max_count:                     nil,
        mode:                          nil,
        payment_type:                  nil,
        period:                        nil,
        registration_reference_number: nil,
        time_of_day:                   nil,
        validated:                     nil
      }
    end

    it 'without values' do
      expect(managed_recurring.managed_recurring_attributes_structure).to eq managed_recurring_structure
    end

    it 'with currency and without max amount' do
      managed_recurring.currency = 'EUR'

      expect(managed_recurring.managed_recurring_attributes_structure).to eq(managed_recurring_structure)
    end

    it 'with currency with valid max amount' do
      managed_recurring.currency                 = 'EUR'
      managed_recurring.managed_recurring_amount = 0.99
      managed_recurring_structure[:amount]       = '99'

      expect(managed_recurring.managed_recurring_attributes_structure).to eq(managed_recurring_structure)
    end

    it 'with currency with invalid max amount' do
      managed_recurring.currency                 = 'EUR'
      managed_recurring.managed_recurring_amount = 'invalid'

      expect { managed_recurring.managed_recurring_attributes_structure }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid max amount without currency' do
      managed_recurring.currency                 = nil
      managed_recurring.managed_recurring_amount = 0.99

      expect { managed_recurring.managed_recurring_attributes_structure }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
