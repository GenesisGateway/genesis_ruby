# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Tokenization::Tokenize do
  let(:test_required_fields) do
    %i[consumer_id email token_type]
  end
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.consumer_id =  Faker::Internet.uuid[..9]
    request.email =        Faker::Internet.email
    request.token_type =   Faker::Lorem.word
    request.card_number =  '1234567890123456789'

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/v1/tokenize'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<tokenize_request>'
    end
  end

  describe 'when scheme_tokenized placement' do
    before { request.scheme_tokenized = true }

    it 'is the last direct child after card_data' do
      expect(
        Nokogiri::XML(request.build_document).xpath('/tokenize_request/card_data/following-sibling::*').map(&:name)
      ).to eq %w(scheme_tokenized)
    end

    it 'is not inside card_data' do
      expect(Nokogiri::XML(request.build_document).xpath('/tokenize_request/card_data//scheme_tokenized')).to be_empty
    end
  end

  include_examples 'base request examples'
  include_examples 'card data attributes examples'
  include_examples 'scheme tokenized attributes examples'
  include_examples 'tokenization api attributes examples'
  include_examples 'versioned request examples'
end
