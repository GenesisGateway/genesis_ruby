# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::BillingApi::EnhancedStatement do
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
    request                 = described_class.new config
    request.currency        = 'EUR'
    request.response_fields = ['id']

    request
  end

  it 'when generated query targets the enhancedBillingStatements query name' do
    expect(request.build_document).to include 'enhancedBillingStatements'
  end

  describe 'when deep nested response_fields selection' do
    let(:summary_selection) do
      { 'summary' => [{ 'grossVolume' => %w(count amount) }, 'netSettlementAmount'] }
    end
    let(:details_selection) do
      {
        'details' => [
          {
            'transactionTypesBreakdown' => [
              {
                'byCurrency' => [
                  {
                    'fees' => [
                      { 'tiers' => %w(rate amount) },
                      'total'
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    end

    let(:document) { request.build_document }

    before { request.response_fields = [summary_selection, details_selection] }

    it 'renders the summary selection preserving names' do
      expect(document).to include('summary').and include('grossVolume').and include('netSettlementAmount')
    end

    it 'renders the deep details selection preserving names and nesting' do
      expect(document).to include('details').and include('transactionTypesBreakdown')
        .and include('byCurrency').and include('fees').and include('tiers').and include('rate')
    end
  end

  describe 'when pricingMethod response field' do
    it 'is accepted as a top-level field without raising' do
      request.response_fields = %w(pricingMethod)

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when next cursor' do
    it 'with backslash and double-quote renders quoted and escaped backslash-first' do
      request.next = %(a\\"b)

      expect(request.build_document).to include 'next: "a\\\\\\"b"'
    end
  end

  describe 'when paging' do
    it 'with per_page rendered bare and not quoted' do # rubocop:disable RSpec/MultipleExpectations
      request.per_page = 100

      document = request.build_document

      expect(document).to include 'perPage: 100'
      expect(document).to_not include 'perPage: "100"'
    end
  end

  # Task 11.5 - empty nested sub-selection and ISO 4217 currency rendering (R6.6, R7.7, R3.4, R3.5)
  describe 'when an empty nested sub-selection is supplied' do
    it 'raises an error identifying the offending node' do
      expect { request.response_fields = [{ 'summary' => [] }] }
        .to raise_error GenesisRuby::InvalidArgumentError, /summary/
    end

    # rubocop:disable RSpec/MultipleExpectations
    it 'emits no query because assignment fails before build' do
      request.response_fields = ['id']

      expect { request.response_fields = [{ 'summary' => [] }] }.to raise_error GenesisRuby::InvalidArgumentError
      expect(request.response_fields).to eq ['id']
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  describe 'when rendering the currency filter' do
    it 'renders a valid ISO 4217 currency as the quoted upper-case value' do
      request.currency = 'eur'

      expect(request.build_document).to include 'currency: "EUR"'
    end

    it 'raises a ParameterError for a non-ISO currency value' do
      request.currency = 'ZZZ'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'abstract statement examples'
  include_examples 'date time from to attributes examples'
end
