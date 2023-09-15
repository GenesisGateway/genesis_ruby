require 'genesis_ruby/utils/options/base'
require 'spec/genesis_ruby/shared_examples/utils/options_examples'

RSpec.describe GenesisRuby::Utils::Options::ApiConfig do
  let(:options) { described_class.new }

  include_examples 'option examples'

  describe 'has pre-loaded data' do
    it 'with XML configuration' do
      options.load_xml_config

      expect(options).to eq({ format: 'xml', port: 443, protocol: 'https', type: 'POST' })
    end

    it 'with JSON configuration' do
      options.load_json_config

      expect(options).to eq({ format: 'json', port: 443, protocol: 'https', type: 'POST' })
    end

    it 'with FORM configuration' do
      options.load_form_config

      expect(options).to eq({ format: 'form', port: 443, protocol: 'https', type: 'POST' })
    end
  end
end
