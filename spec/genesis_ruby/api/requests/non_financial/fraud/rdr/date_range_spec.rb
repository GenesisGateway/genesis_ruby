# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Rdr::DateRange do
  let(:date) { '2023-01-01' }
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

    request.start_date = date
    request.end_date   = date
    request.page       = 1
    request.per_page   = 100
    request.scope      = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::CARD_PRESENT

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/rapid_dispute_resolutions/by_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<rapid_dispute_resolution_request>'
    end
  end

  describe 'when import_date' do
    it 'with import_date only' do
      request.start_date  = nil
      request.import_date = date

      expect(request.build_document).to include "<import_date>#{date}</import_date>"
    end
  end

  describe 'when date value with a time component' do
    it 'with start_date rendered as date only' do
      request.start_date = '2023-01-01 10:30:00'
      request.end_date   = '2023-01-05'

      expect(request.build_document).to include '<start_date>2023-01-01</start_date>'
    end

    it 'with end_date rendered as date only' do
      request.end_date = '2023-01-02 18:45:00'

      expect(request.build_document).to include '<end_date>2023-01-02</end_date>'
    end
  end

  describe 'when required scope' do
    it 'without scope' do
      request.scope = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  describe 'when date range validation' do
    it 'with start_date later than end_date' do
      request.start_date = '2023-02-01'
      request.end_date   = '2023-01-01'

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with both start_date and import_date' do
      request.import_date = date

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'without start_date and import_date' do
      request.start_date = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  describe 'when deprecated parameters' do
    it 'without processing_type in the structure' do
      expect(request.build_document).to_not include 'processing_type'
    end

    it 'without externally_processed in the structure' do
      expect(request.build_document).to_not include 'externally_processed'
    end
  end

  describe 'when paginated response' do
    let(:response) { GenesisRuby::Genesis.new(config, request).execute.response.response_object }

    it 'with page attribute' do
      expect(response[:rapid_dispute_resolution_responses][:page]).to eq '1'
    end

    it 'with per_page attribute' do
      expect(response[:rapid_dispute_resolution_responses][:per_page]).to eq '100'
    end

    it 'with total_count attribute' do
      expect(response[:rapid_dispute_resolution_responses][:total_count]).to eq '2'
    end

    it 'with pages_count attribute' do
      expect(response[:rapid_dispute_resolution_responses][:pages_count]).to eq '1'
    end

    it 'with rapid_dispute_resolution_response nodes' do
      expect(response[:rapid_dispute_resolution_responses][:rapid_dispute_resolution_response].count).to eq 2
    end

    it 'with rapid_dispute_resolution_response arn' do
      expect(response[:rapid_dispute_resolution_responses][:rapid_dispute_resolution_response][0][:arn])
        .to eq '74537604221431003881865'
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'paging attributes examples'
  include_examples 'scope attributes examples'
end
