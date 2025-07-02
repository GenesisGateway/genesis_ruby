# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Create do
  let(:test_required_fields) { %i[payee_type payee_name payee_country] }
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
      payee_type:    %w(company person).sample,
      payee_name:    Faker::Company.name,
      payee_country: GenesisRuby::Utils::Country::COUNTRIES.keys.sample
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_type    = sample_data[:payee_type]
    request.payee_name    = sample_data[:payee_name]
    request.payee_country = sample_data[:payee_country]

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/ExampleLength
    expected_structure = {
      'payee' => {
        'type'    => sample_data[:payee_type],
        'name'    => sample_data[:payee_name],
        'country' => sample_data[:payee_country]
      }
    }

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url'])
      .to eq 'https://staging.api.emerchantpay.net:443/payee'
  end

  it 'when using POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing payee_type should raise error' do
      request.payee_type = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing payee_name should raise error' do
      request.payee_name = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing payee_country should raise error' do
      request.payee_country = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid payee_type values should raise error' do
      request.payee_type = 'invalid_type'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid payee_type company should not raise error' do
      request.payee_type = 'company'
      expect { request.build_document }.to_not raise_error
    end

    it 'with valid payee_type person should not raise error' do
      request.payee_type = 'person'
      expect { request.build_document }.to_not raise_error
    end

    it 'with invalid payee_country values should raise error' do
      request.payee_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
