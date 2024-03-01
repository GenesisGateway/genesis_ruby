RSpec.describe GenesisRuby do
  let(:configuration) do
    config             = described_class::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = described_class::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = described_class::Api::Constants::Environments::STAGING

    config
  end
  let(:request) { GenesisSpec::Stubs::RequestSkeleton.new(configuration) }
  let(:wpf_class) { described_class::Api::Requests::Wpf::Create }

  it 'has a version number' do
    expect(described_class::VERSION).to_not be_nil
  end

  describe 'when static initialization' do
    it 'fails without given block' do
      expect do
        described_class::Genesis.for config: configuration, request: wpf_class
      end.to raise_error described_class::InvalidArgumentError
    end

    it 'fails without correct request class' do
      expect do
        described_class::Genesis.for config: configuration, request: described_class::Api::Response
      end.to raise_error described_class::InvalidArgumentError
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

      expect(genesis.execute.response).to be_kind_of described_class::Api::Response
    end

    it 'executes wpf request with manual initialization' do # rubocop:disable RSpec/ExampleLength
      wpf                    = wpf_class.new configuration
      wpf.amount             = amount_exponent2
      wpf.transaction_id     = Faker::Internet.uuid
      wpf.notification_url   = Faker::Internet.url
      wpf.return_success_url = Faker::Internet.url
      wpf.return_failure_url = Faker::Internet.url
      wpf.return_cancel_url  = Faker::Internet.url
      wpf.currency           = 'EUR'
      wpf.add_transaction_type('sale')

      genesis = described_class::Genesis.new(configuration, wpf)

      expect(genesis.execute.response.response_object).to include(status: 'new')
    end

    it 'executes wpf request with static initialization' do # rubocop:disable RSpec/ExampleLength
      genesis = described_class::Genesis.for(config: configuration, request: wpf_class) do |request|
        request.amount             = amount_exponent2
        request.currency           = 'EUR'
        request.transaction_id     = Faker::Internet.uuid
        request.notification_url   = Faker::Internet.url
        request.return_success_url = Faker::Internet.url
        request.return_failure_url = Faker::Internet.url
        request.return_cancel_url  = Faker::Internet.url
        request.add_transaction_type('sale')
      end.execute

      expect(genesis.response.response_object).to include(status: 'new')
    end
  end
end
