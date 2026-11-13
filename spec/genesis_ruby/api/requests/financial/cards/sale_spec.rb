# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Sale do
  let(:test_required_fields) { %i[transaction_id amount currency] }
  let(:test_required_field_values) do
    %i[
      currency
      recurring_type
      managed_recurring_mode
      managed_recurring_interval
      managed_recurring_mode
      managed_recurring_interval
      managed_recurring_payment_type
      managed_recurring_amount_type
      managed_recurring_frequency
      managed_recurring_validated
    ]
  end
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone_in_e164

    # Credit Card Attributes
    request.card_holder      = Faker::Name.name_with_middle
    request.card_number      = Faker::Finance.credit_card
    request.expiration_month = Faker::Date.in_date_period.strftime '%m'
    request.expiration_year  = Faker::Date.in_date_period.strftime '%Y'
    request.cvv              = Faker::Number.positive from: 100, to: 999

    request
  end

  include_examples 'account owner attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'business attributes examples'
  include_examples 'commercial card attributes examples'
  include_examples 'credential on file attributes examples'
  include_examples 'credential on file transaction link attributes examples'
  include_examples 'credit card attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'digital asset type attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'force threeds excluded examples'
  include_examples 'funding attributes examples'
  include_examples 'fx rate attributes examples'
  include_examples 'gaming attributes examples'
  include_examples 'installment attributes examples'
  include_examples 'managed recurring examples'
  include_examples 'marketplace data attributes examples'
  include_examples 'marketplace data subsequent recurring examples'
  include_examples 'moto attributes examples'
  include_examples 'order attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'purpose of payment attributes examples'
  include_examples 'purpose of payment default allow-list examples'
  include_examples 'recurring category examples'
  include_examples 'recurring type examples'
  include_examples 'reference attributes examples'
  include_examples 'risk attributes examples'
  include_examples 'sca attributes examples'
  include_examples 'scheme tokenized attributes examples'
  include_examples 'tokenization attributes examples'
  include_examples 'tokenization params attributes examples'
  include_examples 'travel data attributes examples'
  include_examples 'ucof attributes examples'

  describe 'when order_id' do
    let(:order_id) { "ORD-#{Faker::Number.number(digits: 8)}" }

    it 'contains order_id with initial recurring type' do
      request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL
      request.order_id       = order_id

      expect(Nokogiri::XML(request.build_document).xpath('/payment_transaction/order_id').text).to eq order_id
    end

    describe 'with subsequent recurring type' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:subsequent_request) do
        subsequent = described_class.new config
        subsequent.transaction_id = Faker::Internet.uuid
        subsequent.amount         = '50.00'
        subsequent.recurring_type =
          GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT
        subsequent.order_id       = order_id
        # Subsequent required fields are applied on field validations init (same as marketplace data examples)
        subsequent.__send__(:init_field_validations)
        subsequent
      end

      it 'builds without error' do
        expect { subsequent_request.build_document }.to_not raise_error
      end

      it 'contains order_id' do
        expect(Nokogiri::XML(subsequent_request.build_document).xpath('/payment_transaction/order_id').text)
          .to eq order_id
      end
    end
  end
end
