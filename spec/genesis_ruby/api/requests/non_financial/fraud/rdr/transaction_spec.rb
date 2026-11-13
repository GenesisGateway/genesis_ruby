# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Rdr::Transaction do
  let(:arn) { '74537604221431003881865' }
  let(:unique_id) { '53b1f5eacc9e4d3a3afebb4e993fe962' }
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

    request.arn = arn

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/rapid_dispute_resolutions'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<rapid_dispute_resolution_request>'
    end

    it 'with arn' do
      expect(request.build_document).to include "<arn>#{arn}</arn>"
    end

    it 'with original_transaction_unique_id' do
      request.arn                            = nil
      request.original_transaction_unique_id = unique_id

      expect(request.build_document)
        .to include "<original_transaction_unique_id>#{unique_id}</original_transaction_unique_id>"
    end
  end

  describe 'when identifier validation' do
    it 'with original_transaction_unique_id and arn' do
      request.original_transaction_unique_id = unique_id

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'without arn and original_transaction_unique_id' do
      request.arn = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty arn and empty original_transaction_unique_id' do
      request.arn                            = ''
      request.original_transaction_unique_id = ''

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty arn and nil original_transaction_unique_id' do
      request.arn = ''

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  describe 'when not found response' do
    let(:genesis) { GenesisRuby::Genesis.new(config, request).execute }

    it 'with error status' do
      expect(genesis.response.error?).to eq true
    end

    it 'with error code' do
      expect(genesis.response.response_object[:code]).to eq '471'
    end

    it 'with error message' do
      expect(genesis.response.response_object[:message]).to eq 'Rapid Dispute Resolution not found!'
    end
  end

  include_examples 'base request examples'
  include_examples 'mode attributes examples'
end
