RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Upi do
  let(:test_required_fields) do
    %i[transaction_id amount currency billing_country]
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

    request.transaction_id          = Faker::Internet.uuid
    request.amount                  = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency                = 'INR'
    request.usage                   = Faker::Lorem.sentence
    request.remote_ip               = Faker::Internet.ip_v4_address
    request.return_success_url      = Faker::Internet.url
    request.return_failure_url      = Faker::Internet.url
    request.customer_email          = Faker::Internet.email
    request.customer_phone          = Faker::PhoneNumber.cell_phone
    request.billing_country         = 'IN'

    request
  end

  describe 'with user_category' do
    it 'when user_category not set' do
      expect(request.build_document).to_not include '<user_category>'
    end

    it 'has user_category' do
      request.user_category = user_category = 'default'

      expect(request.build_document).to include "<user_category>#{user_category}</user_category>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'document attributes examples'
  include_examples 'virtual payment address attributes examples'
end
