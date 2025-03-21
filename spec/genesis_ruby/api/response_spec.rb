RSpec.describe GenesisRuby::Api::Response do
  let(:configuration) { GenesisRuby::Configuration.new }
  let(:response) do
    request_api_config = GenesisRuby::Utils::Options::ApiConfig.new
    request_api_config.load_xml_config

    described_class.new configuration, request_api_config
  end
  let(:network_mock) do
    network = instance_double(GenesisRuby::Network::NetHttp)

    allow(network).to receive(:response_body).and_return(
      File.open("#{File.dirname(File.dirname(__FILE__))}/fixtures/responses/gate_wpf_payment.xml").read
    )

    allow(network).to receive(:json?).and_return(false)
    allow(network).to receive(:xml?).and_return(true)

    network
  end

  it 'can parse network response' do
    expect { response.parse_response(network_mock) }.to_not raise_error
  end

  it 'returns parsed response' do
    expect(response.parse_response(network_mock)).to be_kind_of Hash
  end

  describe 'with parsed response' do
    let(:parsed_response) do
      response.parse_response(network_mock)

      response
    end

    it 'has response raw' do
      expect(parsed_response.response_raw).to be_kind_of String
    end

    it 'has response object' do
      expect(parsed_response.response_object).to be_kind_of Hash
    end

    it 'has dynamic approved? state method' do
      expect(parsed_response.approved?).to eq(false)
    end

    it 'has dynamic new? state method' do
      expect(parsed_response.new?).to eq(true)
    end

    it 'responds correctly with invalid state' do
      expect { parsed_response.invalid_state? }.to raise_error NoMethodError
    end

    it 'responds correctly with any invalid method' do
      expect { parsed_response.invalid_method }.to raise_error NoMethodError
    end

    describe 'with formatting' do
      it 'when amount' do
        expect(parsed_response.response_object[:amount]).to eq('0.99')
      end

      it 'when timestamp' do
        expect(parsed_response.response_object[:timestamp]).to be_kind_of DateTime
      end
    end

    describe 'without formatting' do
      it 'when amount' do
        configuration.format_response = false

        expect(parsed_response.response_object[:amount]).to eq('99')
      end

      it 'when timestamp' do
        configuration.format_response = false

        expect(parsed_response.response_object[:timestamp]).to be_kind_of String
      end
    end

    it 'with sanitization' do
      expect(parsed_response.response_object).to_not include(:empty)
    end

    it 'without sanitization' do
      configuration.sanitize_response = false

      expect(parsed_response.response_object).to include(:empty)
    end
  end

  describe 'without parsed response' do
    it 'has string response raw' do
      expect(response.response_raw).to eq('')
    end

    it 'has object response object' do
      expect(response.response_object).to eq({})
    end

    it 'has dynamic states' do
      expect(response.new?).to eq(false)
    end
  end

  describe 'when parsing error response' do
    let(:configuration) do
      config             = GenesisRuby::Configuration.new
      config.username    = 'example_username'
      config.password    = 'example_password'
      config.token       = 'example_token'
      config.environment = GenesisRuby::Api::Constants::Environments::STAGING
      config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY

      config
    end
    let(:net_http) { GenesisRuby::Network::NetHttp.new(configuration) }
    let(:request) { GenesisSpec::Stubs::RequestSkeleton.new(configuration) }

    it 'with 404 html error response' do
      request.api_config.url = 'https://emerchantpay.net/html_error'
      net_http.init_api_data request
      net_http.send_request

      expect { response.parse_response(net_http) }.to raise_error GenesisRuby::NetworkError
    end

    it 'with 422 html empty error response' do
      request.api_config.url = 'https://emerchantpay.net/error_example_without_body'
      net_http.init_api_data request
      net_http.send_request

      expect { response.parse_response(net_http) }.to raise_error GenesisRuby::NetworkError
    end

    it 'with 400 xml error response' do
      request.api_config.url = 'https://emerchantpay.net/error_example'
      net_http.init_api_data request
      net_http.send_request

      expect(response.parse_response(net_http)).to include :status
    end

  end

  describe 'when json network response' do
    let(:network_mock) do
      network = instance_double(GenesisRuby::Network::NetHttp)

      allow(network).to receive(:response_body).and_return(
        File.open("#{File.dirname(File.dirname(__FILE__))}/fixtures/responses/gate_json_error_response.json").read
      )

      allow(network).to receive(:json?).and_return(true)
      allow(network).to receive(:xml?).and_return(false)

      network
    end

    it 'with json parser' do
      expect { response.parse_response(network_mock) }.to_not raise_error
    end

    it 'returns parsed response' do
      expect(response.parse_response(network_mock)).to be_kind_of Hash
    end

    it 'with error object' do
      expect(response.parse_response(network_mock)).to include :status
    end
  end
end
