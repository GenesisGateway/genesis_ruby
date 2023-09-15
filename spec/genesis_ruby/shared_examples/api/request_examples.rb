RSpec.shared_examples 'request examples' do |environment, endpoint|
  describe "with #{environment} #{endpoint} endpoints" do
    genesis_configuration             = GenesisRuby::Configuration.new

    let(:request) do
      genesis_configuration.token       = 'T0K3N'
      genesis_configuration.endpoint    = endpoint
      genesis_configuration.environment = environment

      described_class.new(genesis_configuration)
    end

    before do
      request.__send__ :init_xml_configuration
    end

    domain    = endpoint == GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY ? 'emerchantpay' : 'e-comprocessing'
    subdomain = environment == GenesisRuby::Api::Constants::Environments::STAGING ? 'staging.' : ''

    it 'build proper API request URL' do
      request.__send__ :init_api_gateway_configuration
      token = genesis_configuration.token

      expect(request.api_config.url).to eq("https://#{subdomain}gate.#{domain}.net:443/process/#{token}/")
    end

    it 'build proper WPF request URL' do
      request.__send__ :init_api_wpf_configuration

      expect(request.api_config.url).to eq("https://#{subdomain}wpf.#{domain}.net:443/wpf")
    end

    it 'build proper internationalized WPF request URL' do
      request.__send__ :init_api_wpf_configuration, { language: 'en' }

      expect(request.api_config.url).to eq("https://#{subdomain}wpf.#{domain}.net:443/en/wpf")
    end

    it 'build proper custom request URL' do
      request.api_config.url = request.__send__ :init_api_gateway_configuration, {
        request_path:  'blacklists',
        include_token: false
      }

      expect(request.api_config.url).to eq("https://#{subdomain}gate.#{domain}.net:443/blacklists")
    end
  end
end
