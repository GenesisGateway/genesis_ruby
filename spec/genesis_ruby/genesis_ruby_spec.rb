# frozen_string_literal: true

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

  it 'with version number' do
    expect(described_class::VERSION).to_not be_nil
  end

  it 'when static initialization without given block' do
    expect { described_class::Genesis.for config: configuration, request: request }
      .to raise_error described_class::InvalidArgumentError
  end

  it 'when static initialization with block' do
    expect do
      described_class::Genesis.for(config: configuration, request: GenesisSpec::Stubs::RequestSkeleton) { |req| }
    end.to_not raise_error
  end

  it 'when static initialization without correct request class' do
    expect do
      described_class::Genesis.for config: configuration, request: described_class::Api::Response
    end.to raise_error described_class::InvalidArgumentError
  end

  describe 'when XML Request' do
    let(:xml_request) do
      request = GenesisRuby::Api::Requests::Financial::Cards::Sale3d.new configuration

      request.transaction_id     = Faker::Internet.uuid
      request.amount             = 1.99
      request.currency           = 'EUR'
      request.notification_url   = Faker::Internet.url
      request.return_success_url = Faker::Internet.url
      request.return_failure_url = Faker::Internet.url
      request.card_holder        = Faker::Name.name_with_middle
      request.card_number        = '4200000000000000'
      request.expiration_month   = '01'
      request.expiration_year    = '2040'
      request.cvv                = '123'

      request
    end
    let(:genesis) { described_class::Genesis.new configuration, xml_request }

    it 'with XML builder_interface' do
      expect(genesis.request.instance_variable_get('@builder_interface')).to eq 'xml'
    end

    it 'when XML body with execute' do
      expect { genesis.execute }.to_not raise_error
    end

    it 'when XML request with response' do
      expect(genesis.execute.response).to be_kind_of described_class::Api::Response
    end
  end

  describe 'when FORM Request' do
    let(:form_request) do
      request = GenesisRuby::Api::Requests::Financial::Cards::Threeds::V2::
          MethodContinue.new configuration

      request.amount                = 1.99
      request.currency              = 'EUR'
      request.transaction_timestamp = '1970-01-01T00:00:00'
      request.transaction_unique_id = '123'

      request
    end
    let(:genesis) { described_class::Genesis.new configuration, form_request }

    it 'with FORM builder_interface' do
      expect(genesis.request.instance_variable_get('@builder_interface')).to eq 'form'
    end

    it 'when FORM request with execute' do
      expect { genesis.execute }.to_not raise_error
    end

    it 'when FORM request with response' do
      expect(genesis.execute.response).to be_kind_of described_class::Api::Response
    end
  end

  describe 'when JSON Request' do
    let(:json_request) do
      request = GenesisRuby::Api::Requests::NonFinancial::Installments::Fetch.new configuration

      request.amount      = 8000
      request.currency    = 'GBP'
      request.card_number = '4005522731304879'

      request
    end
    let(:genesis) { described_class::Genesis.new configuration, json_request }

    it 'with JSON builder_interface' do
      expect(genesis.request.instance_variable_get('@builder_interface')).to eq 'json'
    end

    it 'when JSON request with execute' do
      expect { genesis.execute }.to_not raise_error
    end

    it 'when JSON request with response' do
      expect(genesis.execute.response).to be_kind_of described_class::Api::Response
    end
  end

  describe 'when GET Request' do
    let(:get_request) do
      request = GenesisRuby::Api::Requests::NonFinancial::Installments::Show.new configuration

      request.installment_id = 123

      request
    end
    let(:genesis) { described_class::Genesis.new configuration, get_request }

    it 'when GET request with execute' do
      expect { genesis.execute }.to_not raise_error
    end

    it 'when GET request with response' do
      expect(genesis.execute.response).to be_kind_of described_class::Api::Response
    end
  end

  describe 'when WPF Request' do
    let(:wpf_class) { described_class::Api::Requests::Wpf::Create }

    describe 'when send request' do
      let(:amount_exponent2) { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

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
end
