RSpec.shared_examples 'sdd transaction shared examples' do
  let(:skip_customer_phone) { true }
  let(:skip_customer_email) { true }

  let(:test_required_fields) do
    %i[
      transaction_id usage iban amount currency billing_first_name billing_last_name billing_country
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
    request = described_class.new(config)
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.return_pending_url = Faker::Internet.url
    request.bic                = Faker::Bank.swift_bic
    request.iban               = Faker::Bank.iban
    request.company_name       = Faker::Company.name
    request.mandate_reference  = Faker::Alphanumeric.alphanumeric(number: 20)
    request.billing_first_name = Faker::Name.first_name
    request.billing_last_name  = Faker::Name.last_name
    request.billing_country    = 'DE'
    request.shipping_country   = 'DE'
    request
  end

  describe 'company_name' do
    it 'when build_document with company_name' do
      request.company_name = company_name = Faker::Company.name
      expect(request.build_document).to include("<company_name>#{company_name}</company_name>")
    end
  end

  describe 'mandate_reference' do
    it 'when build_document with mandate_reference' do
      request.mandate_reference = mandate_reference = Faker::Alphanumeric.alphanumeric(number: 20)
      expect(request.build_document).to include("<mandate_reference>#{mandate_reference}</mandate_reference>")
    end
  end

  describe 'billing_country' do
    it 'when build_document with invalid country' do
      request.billing_country = 'CL'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'bank attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'payment attributes examples'
  include_examples 'pending attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'dynamic descriptor examples'
end
