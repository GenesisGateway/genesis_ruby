# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Retrieval::DateRange do
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

    request.start_date           = date
    request.end_date             = date
    request.import_date          = date
    request.page                 = Faker::Number.positive from: 0, to: 4
    request.per_page             = Faker::Number.positive from: 0, to: 20
    request.externally_processed =
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::ExternallyProcessed.all.sample
    request.processing_type      =
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::ProcessingType.all.sample

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/retrieval_requests/by_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<retrieval_request_request>'
    end
  end

  describe 'when page' do
    it 'with number value' do
      request.page = '1'

      expect(request.page).to eq 1
    end

    it 'with string value' do
      request.page = 'abc'

      expect(request.page).to eq 0
    end

    it 'with import_date' do
      expect(request.build_document).to include "<import_date>#{date}</import_date>"
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'externally processed attributes examples'
  include_examples 'paging attributes examples'
  include_examples 'processing type attributes examples'
end
