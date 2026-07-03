# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::AssociatePayeeWithOwners do
  let(:test_required_fields) { %i[payee_unique_id owners] }
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
      payee_unique_id: Faker::Internet.uuid,
      owners:          [
        { unique_id: SecureRandom.uuid, percent_ownership: rand(1..100) },
        { unique_id: SecureRandom.uuid, percent_ownership: rand(1..100) }
      ]
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id = sample_data[:payee_unique_id]
    sample_data[:owners].each do |owner|
      request.add_owner(unique_id: owner[:unique_id], percent_ownership: owner[:percent_ownership])
    end

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/MultipleExpectations
    parsed = JSON.parse(request.build_document)

    expect(parsed['owners'].length).to eq 2
    expect(parsed['owners'][0]['unique_id']).to eq sample_data[:owners][0][:unique_id]
    expect(parsed['owners'][0]['percent_ownership']).to eq sample_data[:owners][0][:percent_ownership]
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq(
      "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/owners"
    )
  end

  it 'when using POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty payee_unique_id should raise error' do
      request.payee_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid payee_unique_id should not raise error' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with no owners raises ParameterError' do
      req = described_class.new config
      req.payee_unique_id = sample_data[:payee_unique_id]

      expect { req.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual payee_unique_id' do
      request.payee_unique_id = 'custom_payee_456'
      request.build_document

      expect(request.api_config['url']).to include('payee/custom_payee_456/owners')
    end
  end

  context 'when using add_owner' do
    it 'raises error with nil unique_id' do
      expect { request.add_owner(unique_id: nil) }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error with empty unique_id' do
      expect { request.add_owner(unique_id: '') }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error with non-string unique_id' do
      expect { request.add_owner(unique_id: 123) }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'adds owner with valid unique_id' do
      request.add_owner(unique_id: 'test_id_123')
      parsed = JSON.parse(request.build_document)

      expect(parsed['owners'].last['unique_id']).to eq 'test_id_123'
    end
  end

  context 'when using owners= setter' do
    it 'assigns valid owners array' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      req = described_class.new config
      req.payee_unique_id = sample_data[:payee_unique_id]
      req.owners = [{ unique_id: 'owner_1' }, { unique_id: 'owner_2' }]

      parsed = JSON.parse(req.build_document)

      expect(parsed['owners'].length).to eq 2
      expect(parsed['owners'][0]['unique_id']).to eq 'owner_1'
    end

    it 'raises error when value is not an Array' do
      expect { request.owners = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error when owner has no unique_id' do
      expect { request.owners = [{ name: 'test' }] }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error when owner unique_id is empty' do
      expect { request.owners = [{ unique_id: '' }] }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'raises error when owner unique_id is not a String' do
      expect { request.owners = [{ unique_id: 123 }] }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  context 'when validating percent_ownership' do
    it 'raises error when percent_ownership is not numeric' do
      expect { request.add_owner(unique_id: 'id_1', percent_ownership: 'fifty') }.to raise_error(
        GenesisRuby::InvalidArgumentError, 'percent_ownership must be numeric'
      )
    end

    it 'raises error when percent_ownership is below 0' do
      expect { request.add_owner(unique_id: 'id_1', percent_ownership: -1) }.to raise_error(
        GenesisRuby::InvalidArgumentError, 'percent_ownership must be between 0.0 and 100.0'
      )
    end

    it 'raises error when percent_ownership is above 100' do
      expect { request.add_owner(unique_id: 'id_1', percent_ownership: 101) }.to raise_error(
        GenesisRuby::InvalidArgumentError, 'percent_ownership must be between 0.0 and 100.0'
      )
    end

    it 'accepts percent_ownership at boundary 0' do
      expect { request.add_owner(unique_id: 'id_1', percent_ownership: 0) }.to_not raise_error
    end

    it 'accepts percent_ownership at boundary 100' do
      expect { request.add_owner(unique_id: 'id_1', percent_ownership: 100) }.to_not raise_error
    end

    it 'raises error via owners= setter when percent_ownership is invalid' do
      expect do
        request.owners = [{ unique_id: 'id_1', percent_ownership: 200 }]
      end.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  include_examples 'base request examples'
end
