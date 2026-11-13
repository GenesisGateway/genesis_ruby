# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Wpf::ReconcileByDate do
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
    request            = described_class.new config
    request.start_date = '2026-01-01 00:00:00'
    request.end_date   = '2026-01-02 00:00:00'
    request
  end
  let(:test_required_fields) { %i[start_date] }

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.wpf.emerchantpay.net:443/wpf/reconcile/by_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<wpf_reconcile>'
    end
  end

  describe 'when dates' do
    it 'without end_date' do
      request.end_date = nil
      expect(request.build_document).to_not include '<end_date>'
    end

    it 'with end_date before start_date' do
      request.end_date = '2025-12-31 23:59:59'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with end_date equal to start_date' do
      request.end_date = request.start_date
      expect { request.build_document }.to_not raise_error
    end

    it 'with range over 7 days' do
      request.end_date = '2026-03-01 00:00:00'
      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when paging' do
    it 'with page and records_per_page' do
      request.page             = 2
      request.records_per_page = 50
      expect(request.build_document)
        .to include('<page>2</page>').and(include('<records_per_page>50</records_per_page>'))
    end

    it 'without page' do
      expect(request.build_document).to_not include '<page>'
    end

    it 'without records_per_page' do
      expect(request.build_document).to_not include '<records_per_page>'
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
end
