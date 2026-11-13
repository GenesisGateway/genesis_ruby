# frozen_string_literal: true

# AbstractStatement is abstract; it is exercised here through the concrete Statement subclass
# to validate the build-time array-size boundaries for billing_statement and master_account_mid.
RSpec.describe GenesisRuby::Api::Requests::Base::NonFinancial::BillingApi::AbstractStatement do
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:statement_class) { GenesisRuby::Api::Requests::NonFinancial::BillingApi::Statement }
  let(:request) do
    request                 = statement_class.new config
    request.response_fields = ['id']

    request
  end
  let(:max_billing_statement) { described_class::MAX_COUNT_BILLING_STATEMENT }
  let(:max_master_account_mid) { described_class::MAX_COUNT_MASTER_ACCOUNT_MID }

  describe 'when billing_statement array size' do
    it 'with exactly the max count is accepted' do
      request.billing_statement = Array.new(max_billing_statement, 'x')

      expect { request.build_document }.to_not raise_error
    end

    it 'when exceeding the max count raises ParameterError' do
      request.billing_statement = Array.new(max_billing_statement + 1, 'x')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when master_account_mid array size' do
    it 'with exactly the max count is accepted' do
      request.master_account_mid = Array.new(max_master_account_mid, 'x')

      expect { request.build_document }.to_not raise_error
    end

    it 'when exceeding the max count raises ParameterError' do
      request.master_account_mid = Array.new(max_master_account_mid + 1, 'x')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
