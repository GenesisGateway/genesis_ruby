# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Retrieval::DateRange do
  let(:date) { '2023-01-01' }
  let(:test_required_fields) { %i[start_date scope] }
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

    request.start_date  = date
    request.end_date    = date
    request.import_date = date
    request.page        = Faker::Number.positive from: 0, to: 4
    request.per_page    = Faker::Number.positive from: 0, to: 20
    request.scope       = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::CARD_PRESENT

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

  describe 'when scope' do
    GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes.all.each do |value|
      it "with #{value} value" do
        request.scope = value

        expect(request.build_document).to include "<scope>#{value}</scope>"
      end
    end

    %w(genesis all).each do |value|
      it "with legacy #{value} value" do
        expect { request.scope = value }.to raise_error(GenesisRuby::InvalidArgumentError)
      end
    end

    it 'with nil value' do
      request.scope = nil

      expect(request.scope).to be_nil
    end
  end

  describe 'when deprecated parameters' do
    it 'without processing_type in the structure' do
      expect(request.build_document).to_not include 'processing_type'
    end

    it 'without externally_processed in the structure' do
      expect(request.build_document).to_not include 'externally_processed'
    end

    it 'without processing_type setter' do
      expect { request.processing_type = 'card_present' }.to raise_error(NoMethodError)
    end

    it 'without externally_processed setter' do
      expect { request.externally_processed = 'genesis' }.to raise_error(NoMethodError)
    end

    it 'without processing_type reader' do
      expect(request).to_not respond_to(:processing_type)
    end

    it 'without externally_processed reader' do
      expect(request).to_not respond_to(:externally_processed)
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'paging attributes examples'
  include_examples 'scope attributes examples'
end
