# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Credit do
  let(:test_required_fields) { %i[transaction_id reference_id amount currency] }
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

    request.transaction_id = Faker::Internet.uuid
    request.amount         = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency       = 'EUR'
    request.usage          = Faker::Lorem.sentence
    request.remote_ip      = Faker::Internet.ip_v4_address
    request.reference_id   = Faker::Internet.uuid

    request
  end

  describe 'when all required fields are set' do
    it 'builds document without errors with complete parameters' do # rubocop:disable RSpec/ExampleLength
      request.crypto                                  = true
      request.reference_id                            = Faker::Internet.uuid
      request.source_of_funds                         =
        GenesisRuby::Api::Constants::Transactions::Parameters::SourceOfFunds.all.sample
      request.purpose_of_payment                      =
        GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all.sample
      request.customer_identification_owner           =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationOwner.all.sample # rubocop:disable Layout/LineLength
      request.customer_identification_type            =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationType.all.sample # rubocop:disable Layout/LineLength
      request.customer_identification_subtype         =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationSubtype.all.sample # rubocop:disable Layout/LineLength
      request.customer_identification_document_id     = Faker::Alphanumeric.alphanumeric(number: 9)
      request.customer_identification_issuing_country = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.account_first_name                      = Faker::Name.first_name
      request.account_middle_name                     = Faker::Name.middle_name
      request.account_last_name                       = Faker::Name.last_name
      request.digital_asset_type                      =
        GenesisRuby::Api::Constants::Transactions::Parameters::DigitalAssetTypes.all.sample

      expect { request.build_document }.to_not raise_error
    end
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'reference attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'account owner attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'customer identification attributes examples'
  include_examples 'source of funds attributes examples'
  include_examples 'purpose of payment attributes examples'
  include_examples 'digital asset type attributes examples'
end
