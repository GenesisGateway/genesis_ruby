# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Owners::DissociateOwners do
  let(:test_required_fields) { %i[owner_unique_id unique_ids] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      owner_unique_id: Faker::Internet.uuid,
      unique_ids:      [SecureRandom.uuid, SecureRandom.uuid]
    }
  end
  let(:request) do
    request = described_class.new config

    request.owner_unique_id = sample_data[:owner_unique_id]
    sample_data[:unique_ids].each { |uid| request.add_unique_id(uid) }

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/MultipleExpectations
    parsed = JSON.parse(request.build_document)

    expect(parsed['owners']['unique_ids'].length).to eq 2
    expect(parsed['owners']['unique_ids'][0]).to eq sample_data[:unique_ids][0]
    expect(parsed['owners']['unique_ids'][1]).to eq sample_data[:unique_ids][1]
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq(
      "https://staging.api.emerchantpay.net:443/payee/owners/#{sample_data[:owner_unique_id]}/owners"
    )
  end

  it 'when using DELETE HTTP request type' do
    expect(request.api_config['type']).to eq 'DELETE'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing owner_unique_id should raise error' do
      request.owner_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty owner_unique_id should raise error' do
      request.owner_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid owner_unique_id should not raise error' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with no unique_ids raises ParameterError' do
      req = described_class.new config
      req.owner_unique_id = sample_data[:owner_unique_id]

      expect { req.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual owner_unique_id' do
      request.owner_unique_id = 'custom_owner_789'
      request.build_document

      expect(request.api_config['url']).to include('payee/owners/custom_owner_789/owners')
    end
  end

  context 'when using add_unique_id' do
    it 'raises error with nil value' do
      expect { request.add_unique_id(nil) }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error with empty value' do
      expect { request.add_unique_id('') }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error with non-string value' do
      expect { request.add_unique_id(123) }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'adds unique_id with valid value' do
      request.add_unique_id('test_id_123')
      parsed = JSON.parse(request.build_document)

      expect(parsed['owners']['unique_ids']).to include('test_id_123')
    end
  end

  context 'when using unique_ids= setter' do
    it 'assigns valid unique_ids array' do
      req = described_class.new config
      req.owner_unique_id = sample_data[:owner_unique_id]
      req.unique_ids = %w(uid_1 uid_2)

      parsed = JSON.parse(req.build_document)

      expect(parsed['owners']['unique_ids']).to eq %w(uid_1 uid_2)
    end

    it 'raises error when value is not an Array' do
      expect { request.unique_ids = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error when array contains non-string value' do
      expect { request.unique_ids = [123] }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error when array contains empty string' do
      expect { request.unique_ids = [''] }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  include_examples 'base request examples'
end
