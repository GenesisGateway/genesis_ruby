require 'spec/genesis_ruby/stubs/request_skeleton'
require 'genesis_ruby/api/constants/endpoints'
require 'genesis_ruby/api/constants/environments'
require 'base64'

RSpec.describe GenesisRuby::Network::NetHttp do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY

    config
  end
  let(:net_http) { described_class.new(configuration) }
  let(:request) { GenesisSpec::Stubs::RequestSkeleton.new(configuration) }

  describe 'has base methods' do
    it 'build user login' do
      expect(net_http.__send__(:build_user_login)).to_not be_empty
    end

    it 'build network user agent' do
      expect(net_http.__send__(:network_user_agent)).to_not be_empty
    end

    it 'map the request' do
      encoded_login = Base64.urlsafe_encode64("#{configuration.username}:#{configuration.password}")
      expect(net_http.__send__(:adapter_data_mapper, request)).to include({ user_login: encoded_login })
    end
  end

  describe 'has integration' do
    it 'fail without request initialization' do
      expect { net_http.send_request }.to raise_error(GenesisRuby::NetworkError)
    end

    it 'can send request' do
      net_http.init_api_data request

      expect { net_http.send_request }.to_not raise_error
    end

    describe 'with request execution' do
      before do
        net_http.init_api_data request
        net_http.send_request
      end

      it 'has response body' do
        expect(net_http.response_body).to include('<status>new</status>')
      end

      it 'has response headers' do
        expect(net_http.response_headers).to include({ 'content-type' => 'application/xml;charset=utf-8' })
      end

      it 'validates xml? correctly with xml response type' do
        expect(net_http.xml?).to eq(true)
      end

      it 'validates json? correctly with xml response type' do
        expect(net_http.json?).to eq(false)
      end

      it 'validates html? correctly with xml response type' do
        expect(net_http.html?).to eq false
      end
    end

    describe 'when html error response' do
      before do
        request.api_config.url = 'https://emerchantpay.net/html_error'
        net_http.init_api_data request
        net_http.send_request
      end

      it 'with response body' do
        expect(net_http.response_body).to_not be_empty
      end

      it 'validates html? correctly' do
        expect(net_http.html?).to eq true
      end

      it 'with error?' do
        expect(net_http.error?).to eq true
      end

      it 'with server_message' do
        expect(net_http.server_message).to eq '404 Not Found'
      end
    end

    describe 'when xml error response with body' do
      before do
        request.api_config.url = 'https://emerchantpay.net/error_example'
        net_http.init_api_data request
        net_http.send_request
      end

      it 'with response body' do
        expect(net_http.response_body).to_not be_empty
      end

      it 'with error?' do
        expect(net_http.error?).to eq true
      end

      it 'with server_message' do
        expect(net_http.server_message).to eq '400 Bad Request'
      end
    end

    describe 'when xml error response without body' do
      before do
        request.api_config.url = 'https://emerchantpay.net/error_example_without_body'
        net_http.init_api_data request
        net_http.send_request
      end

      it 'without response body' do
        expect(net_http.response_body).to be_empty
      end

      it 'validates html? correctly' do
        expect(net_http.html?).to eq true
      end

      it 'with error?' do
        expect(net_http.error?).to eq true
      end

      it 'with server_message' do
        expect(net_http.server_message).to eq '422 Unprocessable Entity'
      end

    end
  end
end
