RSpec.describe GenesisRuby do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) { GenesisSpec::Stubs::RequestSkeleton.new(configuration) }
  let(:wpf_class) { GenesisRuby::Api::Requests::Wpf::Create }

  it 'has a version number' do
    expect(GenesisRuby::VERSION).to_not be_nil
  end

  describe 'when static initialization' do
    it 'fails without given block' do
      expect do
        described_class::Genesis.for config: configuration, request: wpf_class
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'fails without correct request class' do
      expect do
        described_class::Genesis.for config: configuration, request: GenesisRuby::Api::Response
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when send request' do
    let(:amount_exponent2) { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    it 'with execute' do
      genesis = described_class::Genesis.new(configuration, request)

      expect { genesis.execute }.to_not raise_error
    end

    it 'with response' do
      genesis = described_class::Genesis.new(configuration, request)

      expect(genesis.execute.response).to be_kind_of GenesisRuby::Api::Response
    end

    it 'executes wpf request with manual initialization' do
      wpf          = wpf_class.new configuration
      wpf.amount   = amount_exponent2
      wpf.currency = 'EUR'

      genesis = described_class::Genesis.new(configuration, wpf)

      expect(genesis.execute.response.response_object).to include(status: 'new')
    end

    it 'executes wpf request with static initialization' do
      genesis = described_class::Genesis.for(config: configuration, request: wpf_class) do |request|
        request.amount   = amount_exponent2
        request.currency = 'EUR'
      end.execute

      expect(genesis.response.response_object).to include(status: 'new')
    end
  end
end
