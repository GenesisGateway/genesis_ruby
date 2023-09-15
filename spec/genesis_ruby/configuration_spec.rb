RSpec.describe GenesisRuby::Configuration do
  let(:configuration) { described_class.new }

  describe 'without configuration' do
    it 'has string username' do
      expect(configuration.username).to be_kind_of(String)
    end

    it 'has string password' do
      expect(configuration.password).to be_kind_of(String)
    end

    it 'has string token' do
      expect(configuration.token).to be_kind_of(String)
    end

    it 'has string environment' do
      expect(configuration.environment).to be_kind_of(String)
    end

    it 'has string endpoint' do
      expect(configuration.endpoint).to be_kind_of(String)
    end

    it 'has integer timeout' do
      expect(configuration.timeout).to be_kind_of(Integer)
    end

    it 'has default timeout' do
      expect(configuration.timeout).to eq(GenesisRuby::Configuration::DEFAULT_TIMEOUT)
    end

    it 'has default format_response' do
      expect(configuration.format_response).to eq(true)
    end

    it 'has default sanitize_response' do
      expect(configuration.sanitize_response).to eq(true)
    end
  end

  describe 'with proper initialization' do
    it 'initialize configuration module' do
      expect { described_class.new }.to_not raise_error
    end

    it 'set default environment' do
      expect(configuration.environment).to eq(GenesisRuby::Api::Constants::Environments::STAGING)
    end

    it 'set username' do
      configuration.username = 'username'

      expect(configuration.username).to eq('username')
    end

    it 'set password' do
      configuration.password = 'password'

      expect(configuration.password).to eq('password')
    end

    it 'set token' do
      configuration.token = 'token'

      expect(configuration.token).to eq('token')
    end

    it 'set integer timeout' do
      configuration.timeout = 5

      expect(configuration.timeout).to eq(5)
    end

    it 'set string timeout' do
      configuration.timeout = '10'

      expect(configuration.timeout).to eq(10)
    end

    it 'set non zero timeout' do
      configuration.timeout = 'zero evaluation timeout'

      expect(configuration.timeout).to eq(GenesisRuby::Configuration::DEFAULT_TIMEOUT)
    end

    it 'set format_response' do
      configuration.format_response = false

      expect(configuration.format_response).to eq(false)
    end

    it 'set sanitize_response' do
      configuration.sanitize_response = false

      expect(configuration.sanitize_response).to eq(false)
    end
  end

  describe 'with alias environment' do
    it 'set proper production environment' do
      configuration.environment = 'live'

      expect(configuration.environment).to eq(GenesisRuby::Api::Constants::Environments::PRODUCTION)
    end

    it 'set proper staging environment' do
      configuration.environment = 'test'

      expect(configuration.environment).to eq(GenesisRuby::Api::Constants::Environments::STAGING)
    end
  end

  describe 'with valid environment' do
    it 'set proper production environment' do
      configuration.environment = GenesisRuby::Api::Constants::Environments::PRODUCTION

      expect(configuration.environment).to eq(GenesisRuby::Api::Constants::Environments::PRODUCTION)
    end

    it 'set proper staging environment' do
      configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

      expect(configuration.environment).to eq(GenesisRuby::Api::Constants::Environments::STAGING)
    end
  end

  describe 'with invalid environment' do
    it 'throws when environment is invalid' do
      expect { configuration.environment = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'with alias endpoint' do
    it 'set proper emerchantpay endpoint' do
      configuration.endpoint = 'emp'

      expect(configuration.endpoint).to eq(GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY)
    end

    it 'set proper e-comprocessing endpoint' do
      configuration.endpoint = 'ecp'

      expect(configuration.endpoint).to eq(GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING)
    end
  end

  describe 'with valid endpoint' do
    it 'set proper emerchantpay endpoint' do
      configuration.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY

      expect(configuration.endpoint).to eq(GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY)
    end

    it 'set proper e-comprocessing endpoint' do
      configuration.endpoint = GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING

      expect(configuration.endpoint).to eq(GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING)
    end
  end

  describe 'with invalid endpoint' do
    it 'throws when endpoint is invalid' do
      expect { configuration.endpoint = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end
end
