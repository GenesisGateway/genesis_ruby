# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::Status do
  let(:test_required_fields) do
    %i[reference_id]
  end

  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.reference_id = Faker::Number.number(digits: 10)

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'verifications/status'
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
  include_examples 'reference attributes examples'
end
