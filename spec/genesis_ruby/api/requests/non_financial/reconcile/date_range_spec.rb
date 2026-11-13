# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Reconcile::DateRange do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new configuration

    request.start_date = '2023-01-01 12:59:59'
    request.end_date   = '2023-01-01 12:59:59'
    request.page       = Faker::Number.positive from: 0, to: 4

    request
  end

  let(:test_required_fields) { %i[start_date end_date] }

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq "https://staging.gate.emerchantpay.net:443/reconcile/by_date/#{configuration.token}/"
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<reconcile>'
    end

    it 'with page' do
      expect(request.build_document).to include "<page>#{request.page}</page>"
    end
  end

  describe 'when required dates' do
    it 'without start_date' do
      request.start_date = nil
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'without end_date' do
      request.end_date = nil
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when date order' do
    it 'with end_date before start_date' do
      request.start_date = '2026-01-02 00:00:00'
      request.end_date   = '2026-01-01 23:59:59'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with end_date equal to start_date' do
      request.start_date = '2026-01-01 00:00:00'
      request.end_date   = '2026-01-01 00:00:00'
      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when terminal range' do
    before { request.start_date = '2026-01-01 00:00:00' }

    it 'with exactly 7 days' do
      request.end_date = '2026-01-08 00:00:00'
      expect { request.build_document }.to_not raise_error
    end

    it 'with 7 days and 1 second' do
      request.end_date = '2026-01-08 00:00:01'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with date only values' do
      request.start_date = '2026-01-01'
      request.end_date   = '2026-01-09'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when smart router range' do
    before { request.start_date = '2026-01-01 00:00:00' }

    context 'with use_smart_router' do
      before { request.use_smart_router = true }

      it 'with exactly 1 day' do
        request.end_date = '2026-01-02 00:00:00'
        expect { request.build_document }.to_not raise_error
      end

      it 'with 1 day and 1 second' do
        request.end_date = '2026-01-02 00:00:01'
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end

    context 'with force_smart_routing' do
      let(:request) do
        configuration.force_smart_routing = true
        super()
      end

      it 'with exactly 1 day' do
        request.end_date = '2026-01-02 00:00:00'
        expect { request.build_document }.to_not raise_error
      end

      it 'with 1 day and 1 second' do
        request.end_date = '2026-01-02 00:00:01'
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end
  end

  describe 'when endpoint' do
    it 'without smart router' do
      request.build_document
      expect(request.api_config.url).to eq "https://staging.gate.emerchantpay.net:443/reconcile/by_date/#{configuration.token}/"
    end

    it 'with the same body in smart router mode' do
      terminal_body = request.build_document
      request.use_smart_router = true
      expect(request.build_document).to eq terminal_body
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

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'smart router attributes examples'
end
