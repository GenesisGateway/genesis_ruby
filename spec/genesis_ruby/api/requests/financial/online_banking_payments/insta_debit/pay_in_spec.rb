RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::InstaDebit::PayIn do
  let(:test_required_fields) do
    %i[transaction_id
       customer_account_id
       remote_ip
       amount
       currency
       billing_country]
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

    request.transaction_id      = Faker::Internet.uuid
    request.amount              = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency            = 'CAD'
    request.usage               = Faker::Lorem.sentence
    request.remote_ip           = Faker::Internet.ip_v4_address
    request.customer_email      = Faker::Internet.email
    request.customer_phone      = Faker::PhoneNumber.cell_phone
    request.customer_account_id = Faker::Lorem.characters(number: 20)
    request.return_url          = Faker::Internet.url
    request.billing_country     = 'CA'

    request
  end

  describe 'when billing_country' do
    it 'with invalid value' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when return_url' do
    it 'with valid value' do
      request.return_url = url = Faker::Internet.url

      expect(request.build_document).to include "<return_url>#{url}</return_url>"
    end

    it 'with invalid value' do
      expect { request.return_url = 'invalid_value' }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'customer account attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
