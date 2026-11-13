# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::PostDateRange do
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
    request.start_date = Faker::Date.backward.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
    request.end_date   = Faker::Date.backward.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
    request.scope      = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::CARD_PRESENT

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/processed_transactions/by_post_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<processed_transaction_request>'
    end
  end

  describe 'when dates' do
    it 'when start_date without timestamp' do
      date_object        = Faker::Date.backward
      request.start_date = date_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
      date               = date_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601

      expect(request.build_document).to include "<start_date>#{date}</start_date>"
    end

    it 'when end_date without timestamp' do
      date_object      = Faker::Date.backward
      request.end_date = date_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
      date             = date_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601

      expect(request.build_document).to include "<end_date>#{date}</end_date>"
    end
  end

  describe 'when batch_number' do
    it 'with setter' do
      expect { request.batch_number = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with document element' do
      request.batch_number = Faker::Internet.uuid

      expect(request.build_document).to include "<batch_number>#{request.batch_number}</batch_number>"
    end
  end

  describe 'when batch_slip_number' do
    it 'with setter' do
      expect { request.batch_slip_number = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with document element' do
      request.batch_slip_number = Faker::Internet.uuid

      expect(request.build_document).to include "<batch_slip_number>#{request.batch_slip_number}</batch_slip_number>"
    end
  end

  describe 'when deposit_slip_number' do
    it 'with document element' do
      request.deposit_slip_number = Faker::Internet.uuid

      expect(request.build_document)
        .to include "<deposit_slip_number>#{request.deposit_slip_number}</deposit_slip_number>"
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
