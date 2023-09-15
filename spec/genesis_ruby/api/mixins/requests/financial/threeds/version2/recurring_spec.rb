require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/recurring_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Recurring  do
  let(:recurring) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::RecurringStub.new
  end

  describe 'when threeds_v2_recurring_expiration_date' do
    it 'with default value' do
      expect(recurring.threeds_v2_recurring_expiration_date).to eq(nil)
    end

    it 'with empty date' do
      recurring.threeds_v2_recurring_expiration_date = Faker::Date.in_date_period.strftime('%Y-%m-%d')
      recurring.threeds_v2_recurring_expiration_date = ''

      expect(recurring.threeds_v2_recurring_expiration_date).to eq(nil)
    end

    it 'with valid date' do
      date = Faker::Date.in_date_period
      recurring.threeds_v2_recurring_expiration_date = date.strftime('%Y-%m-%d')

      expect(recurring.threeds_v2_recurring_expiration_date).to eq(date.strftime('%d-%m-%Y'))
    end

    it 'with invalid date' do
      expect do
        recurring.threeds_v2_recurring_expiration_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_recurring_frequency' do
    it 'with integer value' do
      recurring.threeds_v2_recurring_frequency = frequency = 2

      expect(recurring.threeds_v2_recurring_frequency).to eq(frequency)
    end

    it 'with string value' do
      recurring.threeds_v2_recurring_frequency = frequency = '2'

      expect(recurring.threeds_v2_recurring_frequency).to eq(frequency.to_i)
    end

    it 'with empty value' do
      recurring.threeds_v2_recurring_frequency = ''

      expect(recurring.threeds_v2_recurring_frequency).to eq(nil)
    end

    it 'with zero value' do
      recurring.threeds_v2_recurring_frequency = 0

      expect(recurring.threeds_v2_recurring_frequency).to eq(nil)
    end

    it 'with min value' do
      recurring.threeds_v2_recurring_frequency = frequency = 1

      expect(recurring.threeds_v2_recurring_frequency).to eq(frequency)
    end

    it 'with max value' do
      recurring.threeds_v2_recurring_frequency = frequency = 9999

      expect(recurring.threeds_v2_recurring_frequency).to eq(frequency)
    end

    it 'with invalid value' do
      expect do
        recurring.threeds_v2_recurring_frequency = 10_000
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(recurring.recurring_attributes).to_not be_empty
  end

end
