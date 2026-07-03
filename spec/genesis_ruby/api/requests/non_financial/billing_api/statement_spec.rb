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
    request.start_date      = '1970-01-01'
    request.end_date        = '1970-01-07'
    request.response_fields = ['id']

    request
  end

  it 'when request without any filter' do
    request.start_date = nil
    request.end_date   = nil

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  describe 'when start_date / end_date range' do
    it 'with equal dates raises error' do
      request.start_date = '1970-01-01'
      request.end_date   = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with end_date before start_date raises error' do
      request.start_date = '1970-01-05'
      request.end_date   = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with more than 7 days difference raises error' do
      request.start_date = '1970-01-01'
      request.end_date   = '1970-01-09'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with only start_date raises error' do
      request.end_date = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with only end_date raises error' do
      request.start_date = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when start_date_from / start_date_to range' do
    it 'with only start_date_from raises error' do
      request.start_date_from = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with only start_date_to raises error' do
      request.start_date_to = '1970-01-07'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with equal dates raises error' do
      request.start_date_from = '1970-01-01'
      request.start_date_to   = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with more than 7 days difference raises error' do
      request.start_date_from = '1970-01-01'
      request.start_date_to   = '1970-01-09'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid range builds document' do # rubocop:disable RSpec/MultipleExpectations
      request.start_date_from = '1970-01-01'
      request.start_date_to   = '1970-01-07'

      expect(request.build_document).to include 'startDateFrom'
      expect(request.build_document).to include 'startDateTo'
    end
  end

  describe 'when end_date_from / end_date_to range' do
    it 'with only end_date_from raises error' do
      request.end_date_from = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with only end_date_to raises error' do
      request.end_date_to = '1970-01-07'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid range builds document' do # rubocop:disable RSpec/MultipleExpectations
      request.end_date_from = '1970-01-01'
      request.end_date_to   = '1970-01-07'

      expect(request.build_document).to include 'endDateFrom'
      expect(request.build_document).to include 'endDateTo'
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

    it 'with currency as only filter builds document' do
      request.start_date = nil
      request.end_date   = nil
      request.currency   = 'EUR'

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

    it 'with creation_date as only filter builds document' do
      request.start_date    = nil
      request.end_date      = nil
      request.creation_date = '1970-06-15'

      expect(request.build_document).to_not be_empty
    end
  end

  describe 'when billing_statement' do
    it 'with invalid non-array value raises error' do
      expect { request.billing_statement = 'not-an-array' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value is included in document' do
      request.start_date        = nil
      request.end_date          = nil
      request.billing_statement = ['BS-001']

      expect(request.build_document).to include 'billingStatement: ["BS-001"]'
    end

    it 'when exceeding max count raises error' do
      request.billing_statement = Array.new(
        described_class::MAX_COUNT_BILLING_STATEMENT + 1, 'x'
      )

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when next cursor' do
    it 'with next value is included in paging arguments' do
      request.next = 'cursor-abc'

      expect(request.build_document).to include 'cursor-abc'
    end
  end

  describe 'when response_fields' do
    it 'with invalid non-array value raises error' do
      expect { request.response_fields = 'id' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid array value raises error' do
      expect { request.response_fields = %w(invalid_field) }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value raises error' do
      r              = described_class.new config
      r.start_date   = '1970-01-01'
      r.end_date     = '1970-01-07'

      expect { r.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with summary expands sub-fields' do
      request.response_fields = ['summary']

      expect(request.build_document).to include 'grossVolume'
    end

    it 'with details expands sub-fields' do
      request.response_fields = ['details']

      expect(request.build_document).to include 'transactionTypesBreakdown'
    end

    it 'with plain field is included as-is' do
      request.response_fields = ['id']

      expect(request.build_document).to include 'id'
    end
  end

  describe 'when sort attributes' do
    it 'with invalid sort_by_field raises error at build time' do
      request.sort_by_field = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid sort_by_field is included in document' do
      request.sort_by_field = described_class::ORDER_BY_FIELDS.first

      expect(request.build_document).to include "byField: #{described_class::ORDER_BY_FIELDS.first}"
    end
  end

  describe 'when paging' do
    it 'with per_page is included in paging arguments' do
      request.per_page = 10

      expect(request.build_document).to include 'perPage: 10'
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'graphql request examples'
  include_examples 'sort attributes examples', described_class::ORDER_BY_FIELDS.sample
  include_examples 'versioned request examples'
end
