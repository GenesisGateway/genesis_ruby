# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::BillingApi::Statement do
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
  let(:order_by_fields) do
    GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::StatementOrderByFields
  end
  let(:max_billing_statement) do
    GenesisRuby::Api::Requests::Base::NonFinancial::BillingApi::AbstractStatement::MAX_COUNT_BILLING_STATEMENT
  end

  describe 'when valid filter combination' do
    before do
      request.start_date_from = '1970-01-01'
      request.start_date_to   = '1970-01-07'
      request.currency        = 'EUR'
      request.status          = 'paid'
    end

    # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
    it 'produces a well-formed billingStatements query' do
      document = request.build_document

      expect(document).to include 'billingStatements(filter: {'
      expect(document).to include 'startDateFrom: "1970-01-01"'
      expect(document).to include 'startDateTo: "1970-01-07"'
      expect(document).to include 'currency: "EUR"'
      expect(document).to include 'status: paid'
    end
    # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength

    it 'omits the startDate and endDate filters' do # rubocop:disable RSpec/MultipleExpectations
      document = request.build_document

      expect(document).to_not include 'startDate:'
      expect(document).to_not include 'endDate:'
    end
  end

  describe 'when currency' do
    it 'with invalid value raises error' do
      request.currency = 'INVALID'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid value is included in document' do
      request.currency = 'eur'

      expect(request.build_document).to include 'currency: "EUR"'
    end
  end

  describe 'when status' do
    it 'with invalid value raises error' do
      request.status = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    described_class::STATUSES.each do |s|
      it "with valid value '#{s}' is included in document" do
        request.status = s

        expect(request.build_document).to include "status: #{s}"
      end
    end
  end

  describe 'when creation_date' do
    it 'with invalid value raises error' do
      expect { request.creation_date = 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value is included in document' do # rubocop:disable RSpec/MultipleExpectations
      request.creation_date = '1970-06-15'

      expect(request.build_document).to include 'creationDate'
      expect(request.build_document).to include '1970-06-15'
    end
  end

  describe 'when billing_statement' do
    it 'with invalid non-array value raises error' do
      expect { request.billing_statement = 'not-an-array' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value is included in document' do
      request.billing_statement = ['BS-001']

      expect(request.build_document).to include 'billingStatement: ["BS-001"]'
    end

    it 'when exceeding max count raises error' do
      request.billing_statement = Array.new(max_billing_statement + 1, 'x')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when master_account_mid' do
    it 'with valid value rendered as escaped list literal' do
      request.master_account_mid = %w(mid-1 mid-2)

      expect(request.build_document).to include 'masterAccountMID: ["mid-1","mid-2"]'
    end

    it 'with masterAccountMID accepted as a response field' do
      request.currency        = 'EUR'
      request.response_fields = ['masterAccountMID']

      expect(request.build_document).to include 'masterAccountMID'
    end
  end

  describe 'when empty-value filters' do
    it 'omits an empty string filter from the generated query' do
      request.currency       = 'EUR'
      request.payment_method = ''

      expect(request.build_document).to_not include 'paymentMethod'
    end

    it 'omits an empty array filter from the generated query' do
      request.currency           = 'EUR'
      request.master_account_mid = []

      expect(request.build_document).to_not include 'masterAccountMID'
    end

    # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
    it 'omits empty filters while retaining a non-empty filter' do
      request.currency           = 'EUR'
      request.payment_method     = ''
      request.master_account_mid = []

      document = request.build_document

      expect(document).to include 'currency: "EUR"'
      expect(document).to_not include 'paymentMethod'
      expect(document).to_not include 'masterAccountMID'
    end
    # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
  end

  describe 'when response_fields' do
    it 'with invalid non-array value raises error' do
      expect { request.response_fields = 'id' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty sub-selection raises error' do
      expect { request.response_fields = [{ summary: [] }] }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid top-level field raises error at build time' do
      request.currency        = 'EUR'
      request.response_fields = %w(invalid_field)

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with pricingMethod requested raises error at build time' do
      request.currency        = 'EUR'
      request.response_fields = %w(pricingMethod)

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with caller-supplied nested selection rendered as given' do # rubocop:disable RSpec/MultipleExpectations
      request.currency        = 'EUR'
      request.response_fields = ['id', { summary: %w(grossVolume netVolume) }]

      document = request.build_document

      expect(document).to include 'grossVolume'
      expect(document).to include 'netVolume'
    end

    it 'with plain field is included as-is' do
      request.currency        = 'EUR'
      request.response_fields = ['id']

      expect(request.build_document).to include 'id'
    end
  end

  describe 'when next cursor' do
    it 'with next value is included in paging arguments' do
      request.currency = 'EUR'
      request.next     = 'cursor-abc'

      expect(request.build_document).to include 'cursor-abc'
    end

    it 'with backslash and double-quote renders quoted and escaped backslash-first' do
      request.currency = 'EUR'
      request.next     = %(a\\"b)

      expect(request.build_document).to include 'next: "a\\\\\\"b"'
    end
  end

  describe 'when sort attributes' do
    it 'with invalid sort_by_field raises error at build time' do
      request.currency      = 'EUR'
      request.sort_by_field = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid sort_by_field is included in document' do
      request.currency      = 'EUR'
      request.sort_by_field = order_by_fields.all.first

      expect(request.build_document).to include "byField: #{order_by_fields.all.first}"
    end
  end

  describe 'when paging' do
    it 'with per_page is included in paging arguments' do
      request.currency = 'EUR'
      request.per_page = 10

      expect(request.build_document).to include 'perPage: 10'
    end

    it 'with per_page rendered bare and not quoted' do # rubocop:disable RSpec/MultipleExpectations
      request.currency = 'EUR'
      request.per_page = 100

      document = request.build_document

      expect(document).to include 'perPage: 100'
      expect(document).to_not include 'perPage: "100"'
    end
  end

  include_examples 'abstract statement examples'
  include_examples 'base request examples'
  include_examples 'date time from to attributes examples'
  include_examples 'graphql request examples'
  include_examples 'sort attributes examples',
                   GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
                     StatementOrderByFields.all.sample
  include_examples 'versioned request examples'
end
