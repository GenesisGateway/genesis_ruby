# frozen_string_literal: true

require 'genesis_ruby/utils/options/base'
require 'spec/genesis_ruby/shared_examples/utils/options_examples'

RSpec.describe GenesisRuby::Utils::Options::ApiConfig do
  let(:options) { described_class.new }

  include_examples 'option examples'

  describe 'has pre-loaded data' do
    let(:basic_options) do
      {
        authorization:         'basic',
        bearer_token:          nil,
        format:                'xml',
        parser_skip_root_node: true,
        port:                  443,
        protocol:              'https',
        type:                  'POST'
      }

    end

    it 'with XML configuration' do
      options.load_xml_config

      expect(options).to eq basic_options
    end

    it 'with JSON configuration' do
      options.load_json_config

      expect(options).to eq basic_options.merge({ format: 'json', parser_skip_root_node: false })
    end

    it 'with FORM configuration' do
      options.load_form_config

      expect(options).to eq basic_options.merge({ format: 'form' })
    end

    it 'with GET configuration' do
      options.load_get_config

      expect(options).to eq basic_options.merge({ parser_skip_root_node: false, type: 'GET' })
    end

    it 'with GraphQL configuration' do
      options.load_graphql_config

      expect(options)
        .to eq basic_options.merge(
          { authorization: 'bearer', bearer_token: nil, format: 'graphql', parser_skip_root_node: false }
        )
    end
  end
end
