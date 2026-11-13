# frozen_string_literal: true

RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe GenesisRuby::Api::Requests::Wpf::Reconcile do
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

    request.unique_id = Faker::Internet.uuid

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.wpf.emerchantpay.net:443/wpf/reconcile'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<wpf_reconcile>'
    end

    it 'with unique_id' do
      expect(request.build_document).to include "<unique_id>#{request.unique_id}</unique_id>"
    end
  end

  describe 'when search parameters' do
    it 'with arn' do
      request.unique_id = nil
      request.arn       = Faker::Internet.uuid
      document = request.build_document
      expect(document).to include("<arn>#{request.arn}</arn>").and(not_include('<unique_id>'))
    end

    it 'with transaction_id' do
      request.unique_id      = nil
      request.transaction_id = Faker::Internet.uuid
      document = request.build_document
      expect(document).to include("<transaction_id>#{request.transaction_id}</transaction_id>")
        .and(not_include('<unique_id>'))
    end

    it 'with unique_id only' do
      document = request.build_document
      expect(document).to include("<unique_id>#{request.unique_id}</unique_id>")
        .and(not_include('<arn>')).and(not_include('<transaction_id>'))
    end

    it 'with none provided' do
      request.unique_id = nil
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with several provided' do
      request.arn = Faker::Internet.uuid
      expect { request.build_document }.to_not raise_error
    end
  end

  include_examples 'base request examples'
end
