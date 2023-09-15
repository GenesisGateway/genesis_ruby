require 'genesis_ruby/utils/options/base'
require 'genesis_ruby/utils/options/network_adapter_config'
require 'genesis_ruby/api/request'

RSpec.describe GenesisRuby::Utils::Options::NetworkAdapterConfig do
  let(:options) { described_class.new }
  let(:request) { GenesisRuby::Api::Request.new(GenesisRuby::Configuration.new) }

  include_examples 'option examples'

  describe 'has data mapper' do
    it 'map XML format request' do
      request.api_config.format = 'xml'
      options.map_from_request(request)

      expect(options).to include(format: 'text/xml')
    end

    it 'map JSON request format' do
      request.api_config.format = 'json'
      options.map_from_request(request)

      expect(options).to include(format: 'application/json')
    end

    it 'map FORM request format' do
      request.api_config.format = 'form'
      options.map_from_request(request)

      expect(options).to include(format: 'application/x-www-form-urlencoded')
    end

  end
end
