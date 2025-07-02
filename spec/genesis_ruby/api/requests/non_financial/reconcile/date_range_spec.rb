# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Reconcile::DateRange do
  let(:date) { '2023-01-01' }
  let(:time) { '12:59:59' }
  let(:timestamp_object) do
    GenesisRuby::Utils::Common.parse_date(
      "#{date} #{time}",
      GenesisRuby::Api::Constants::DateTimeFormats.all
    )
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

    request.start_date = timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
    request.end_date   = timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
    request.page       = Faker::Number.positive from: 0, to: 4

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq "https://staging.gate.emerchantpay.net:443/reconcile/by_date/#{config.token}/"
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<reconcile>'
    end

    it 'with page' do
      expect(request.build_document).to include "<page>#{request.page}</page>"
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
end
