RSpec.shared_examples 'south american payment examples' do
  let(:test_required_fields) do
    %i[transaction_id amount currency consumer_reference national_id customer_email billing_country]
  end
  let(:test_required_field_values) { %i[billing_country] }
  let(:skip_customer_phone) { true }
  let(:config) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration.token       = Faker::Internet.uuid

    configuration
  end
  let(:init_request) do
    request.transaction_id     = Faker::Internet.uuid
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.amount             = 1.99
    request.currency           = 'EUR'
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.consumer_reference = Faker::Internet.uuid[..19]
    request.national_id        = Faker::Internet.uuid[..19]
    request.customer_email     = Faker::Internet.email
  end

  before { init_request }

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'consumer identifier attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
