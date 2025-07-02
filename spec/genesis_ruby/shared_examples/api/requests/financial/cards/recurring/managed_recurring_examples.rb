# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.shared_examples 'managed recurring examples' do
  let(:mode) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Modes.all.sample }
  let(:interval) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Intervals.all.sample }
  let(:amount_type) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::AmountTypes.all.sample }
  let(:amount) { Faker::Number.decimal r_digits: 2 }
  let(:timestamp) { Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats.all.sample }
  let(:frequency) { GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::Frequencies.all.sample }
  let(:integer) { Faker::Number.positive.to_i }
  let(:payment_type) do
    GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::PaymentTypes.all.sample
  end
  let(:uuid) { Faker::Internet.uuid }
  let(:amount_exponent) { GenesisRuby::Utils::MoneyFormat.amount_to_exponent(amount, request.currency) }

  let(:managed_recurring) do
    request.managed_recurring_mode                          = mode
    request.managed_recurring_interval                      = interval
    request.managed_recurring_amount                        = amount
    request.managed_recurring_amount_type                   = amount_type
    request.managed_recurring_first_date                    = timestamp
    request.managed_recurring_frequency                     = frequency
    request.managed_recurring_max_amount                    = amount
    request.managed_recurring_max_count                     = integer
    request.managed_recurring_payment_type                  = payment_type
    request.managed_recurring_period                        = integer
    request.managed_recurring_registration_reference_number = uuid
    request.managed_recurring_time_of_day                   = integer
    request.managed_recurring_validated                     = true

    request
  end

  describe 'when managed recurring' do
    it 'without managed_recurring attributes' do
      expect(request.build_document).to_not include '<managed_recurring>'
    end

    it 'with managed_recurring attributes' do
      expect(managed_recurring.build_document).to include '<managed_recurring>'
    end

    it 'with managed_recurring_mode' do
      expect(managed_recurring.build_document).to include "<mode>#{mode}</mode>"
    end

    it 'with managed_recurring_interval' do
      expect(managed_recurring.build_document).to include "<interval>#{interval}</interval>"
    end

    it 'with managed_recurring_amount' do
      expect(managed_recurring.build_document).to include "<amount>#{amount_exponent}</amount>"
    end

    it 'with managed_recurring_amount_type' do
      expect(managed_recurring.build_document).to include "<amount_type>#{amount_type}</amount_type>"
    end

    it 'with managed_recurring_first_date' do
      date = DateTime.parse(timestamp).strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601)

      expect(managed_recurring.build_document).to include "<first_date>#{date}</first_date>"
    end

    it 'with managed_recurring_amount_frequency' do
      expect(managed_recurring.build_document).to include "<frequency>#{frequency}</frequency>"
    end

    it 'with managed_recurring_max_amount' do
      expect(managed_recurring.build_document).to include "<max_amount>#{amount_exponent}</max_amount>"
    end

    it 'with managed_recurring_max_count' do
      expect(managed_recurring.build_document).to include "<max_count>#{integer}</max_count>"
    end

    it 'with managed_recurring_payment_type' do
      expect(managed_recurring.build_document).to include "<payment_type>#{payment_type}</payment_type>"
    end

    it 'with managed_recurring_period' do
      expect(managed_recurring.build_document).to include "<period>#{integer}</period>"
    end

    it 'with managed_recurring_registration_reference_number' do
      expect(managed_recurring.build_document)
        .to include "<registration_reference_number>#{uuid}</registration_reference_number>"
    end

    it 'with managed_recurring_time_of_day' do
      expect(managed_recurring.build_document).to include "<time_of_day>#{integer}</time_of_day>"
    end

    it 'with managed_recurring_validated' do
      expect(managed_recurring.build_document).to include '<validated>true</validated>'
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
