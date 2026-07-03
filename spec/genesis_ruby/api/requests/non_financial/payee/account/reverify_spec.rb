# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Account::Reverify do
  let(:test_required_fields) { %i[payee_unique_id account_unique_id] }
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      payee_unique_id:   Faker::Internet.uuid,
      account_unique_id: Faker::Internet.uuid
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id   = sample_data[:payee_unique_id]
    request.account_unique_id = sample_data[:account_unique_id]

    request
  end

  it 'when building document with empty request structure' do
    expect(JSON.parse(request.build_document)).to eq({})
  end

  context 'when valid request' do
    it 'when configured with proper endpoint url' do
      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}" \
               "/account/#{sample_data[:account_unique_id]}/reverify"
    end

    it 'when using POST HTTP request type' do
      expect(request.api_config['type']).to eq 'POST'
    end

    it 'with all fields should not raise error' do
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when invalid request' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty payee_unique_id should raise error' do
      request.payee_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing account_unique_id should raise error' do
      request.account_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty account_unique_id should raise error' do
      request.account_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  # Property 1: URL path substitution preserves identifiers
  # Validates: Requirements 3.2, 3.3, 3.4
  context 'when verifying URL path substitution with random identifiers', feature: 'payee-reverify-account' do
    it 'preserves both UUIDs at the correct path positions ending with /reverify' do # rubocop:disable RSpec/ExampleLength
      100.times do
        payee_id   = Faker::Internet.uuid
        account_id = Faker::Internet.uuid

        fresh_request = described_class.new config

        fresh_request.payee_unique_id   = payee_id
        fresh_request.account_unique_id = account_id

        fresh_request.build_document

        expect(fresh_request.api_config['url'])
          .to eq "https://staging.api.emerchantpay.net:443/payee/#{payee_id}/account/#{account_id}/reverify"
      end
    end
  end

  include_examples 'base request examples'
end
