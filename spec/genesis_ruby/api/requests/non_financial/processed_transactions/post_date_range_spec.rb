RSpec.describe GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::PostDateRange do
  let(:test_required_fields) { %i[start_date] }
  let(:test_required_field_values) { %i[externally_processed processing_type] }
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

    request
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

  describe 'when externally_processed' do
    it 'without value' do
      expect(request.build_document).to_not include 'externally_processed'
    end
  end

  describe 'when processing_type' do
    it 'without value' do
      expect(request.build_document).to_not include 'processing_type'
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'externally processed attributes examples'
  include_examples 'paging attributes examples'
  include_examples 'processing type attributes examples'
end
