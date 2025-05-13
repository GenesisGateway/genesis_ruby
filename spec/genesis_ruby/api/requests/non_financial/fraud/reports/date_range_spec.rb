RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Reports::DateRange do
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
    request.page       = Faker::Number.positive from: 0, to: 4
    request.per_page   = Faker::Number.positive from: 0, to: 20

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/fraud_reports/by_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<fraud_report_request>'
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
  end

  describe 'when field validations' do
    it 'with missing required parameters' do
      request.start_date = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with more than one required parameter' do
      request.import_date = date

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing end_date when start_date is set' do
      request.end_date = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing report_end_date when report_start_date is set' do
      request.start_date        = nil
      request.report_start_date = date

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  describe 'when import_date' do
    it 'with value' do
      request.start_date  = nil
      request.import_date = date

      expect(request.build_document).to include "<import_date>#{date}</import_date>"
    end

    it 'without assignement' do
      expect(request.build_document).to_not include '<import_date>'
    end
  end

  describe 'when report_start_date' do
    it 'with value' do
      request.start_date        = nil
      request.report_start_date = date
      request.report_end_date   = date

      expect(request.build_document).to include "<report_start_date>#{date}</report_start_date>"
    end

    it 'without assignement' do
      expect(request.build_document).to_not include '<report_start_date>'
    end
  end

  describe 'when report_end_date' do
    it 'with value' do
      request.start_date        = nil
      request.report_start_date = date
      request.report_end_date   = date

      expect(request.build_document).to include "<report_end_date>#{date}</report_end_date>"
    end

    it 'without assignement' do
      expect(request.build_document).to_not include '<report_end_date>'
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'paging attributes examples'
end
