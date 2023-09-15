RSpec.describe GenesisRuby::Network::Adapter::NetHttpAdapter do
  let(:net_http) { described_class.new }

  describe 'without initialization' do
    it 'not fail when call status' do
      expect { net_http.status }.to_not raise_error
    end

    it 'not fail when call response_body' do
      expect { net_http.response_body }.to_not raise_error
    end

    it 'has empty response_body' do
      expect(net_http.response_body).to be_empty
    end

    it 'not fail when call response_headers' do
      expect { net_http.response_headers }.to_not raise_error
    end

    it 'has empty response_headers' do
      expect(net_http.response_headers).to eq({})
    end

    it 'fail when url empty with NetworkError' do
      expect do
        net_http.prepare_request(GenesisRuby::Utils::Options::NetworkAdapterConfig.new)
      end.to raise_error(GenesisRuby::NetworkError)
    end

    it 'fail when execute with NetworkError' do
      expect { net_http.execute }.to raise_error(GenesisRuby::NetworkError)
    end
  end

  describe 'with initialization' do
    let(:adapter_config) { GenesisRuby::Utils::Options::NetworkAdapterConfig.new }

    it 'not fail with url' do
      adapter_config.url = 'https://emerchantpay.net/'

      expect { net_http.prepare_request(adapter_config) }.to_not raise_error
    end

    it 'not fail with url without path' do
      adapter_config.url = 'https://emerchantpay.net'

      expect { net_http.prepare_request(adapter_config) }.to_not raise_error
    end

    it 'can execute request' do
      adapter_config.url = 'https://emerchantpay.net/success_example'
      net_http.prepare_request(adapter_config)
      net_http.execute

      expect(net_http.response_body).to_not be_empty
    end

    it 'has 200 status code' do
      adapter_config.url = 'https://emerchantpay.net/success_example'
      net_http.prepare_request(adapter_config)
      net_http.execute

      expect(net_http.status).to eq('200')
    end

    it 'has 400 status code' do
      adapter_config.url = 'https://emerchantpay.net/error_example'
      net_http.prepare_request(adapter_config)
      net_http.execute

      expect(net_http.status).to eq('400')
    end

    it 'has NetworkError error when SystemError' do
      stub_request(:any, %r{emerchantpay.net/timeout_error}).to_timeout
      adapter_config.url = 'https://emerchantpay.net/timeout_error'
      net_http.prepare_request(adapter_config)

      expect { net_http.execute }.to raise_error(GenesisRuby::NetworkError)
    end
  end
end
