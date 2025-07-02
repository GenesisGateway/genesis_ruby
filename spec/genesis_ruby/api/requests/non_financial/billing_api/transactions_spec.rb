# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::BillingApi::Transactions do
  let(:test_required_field_values) { %i[sort_by_direction] }
  let(:uuid) { Faker::Internet.uuid }
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
    request            =              described_class.new config
    request.start_date =              '1970-01-01'
    request.end_date   =              '1970-01-07'
    request.unique_id  =              [uuid]
    request.billing_statement =       [uuid]
    request.merchant_transaction_id = [uuid]
    request.response_fields =         [
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::ResponseFields.all.sample
    ]

    request
  end

  it 'when request without primary filters' do
    request.start_date = nil
    request.end_date   = nil
    request.unique_id  = request.billing_statement = request.merchant_transaction_id = []

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  describe 'when date attributes' do
    it 'with equal dates' do
      request.start_date = '1970-01-01'
      request.end_date   = '1970-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with equal timestamps' do
      request.start_date = '1970-01-01 00:00:00'
      request.end_date   = '1970-01-01 00:00:00'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with end_date less than start_date' do
      request.end_date   = '1970-01-01'
      request.start_date = '1970-01-02'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with end_date timestamp less than start_date timestamp' do
      request.end_date   = '1970-01-01 00:00:00'
      request.start_date = '1970-01-01 00:00:01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'when start_date and end_date with more than 7 days difference' do
      request.start_date = '1970-01-01'
      request.end_date   = '1970-01-09'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'when start_date and end_date timestamps with more than 7 days difference' do
      request.start_date = '1970-01-01 00:00:00'
      request.end_date   = '1970-01-08 00:00:01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when unique_id' do
    it 'with invalid value' do
      expect { request.unique_id = uuid }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      expect(request.build_document).to include "uniqueId: [\"#{uuid}\"]"
    end
  end

  describe 'when billing_statement' do
    it 'with invalid value' do
      expect { request.billing_statement = uuid }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      expect(request.build_document).to include "billingStatement: [\"#{uuid}\"]"
    end
  end

  describe 'when merchant_transaction_id' do
    it 'with invalid value' do
      expect { request.merchant_transaction_id = uuid }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      expect(request.build_document).to include "merchantTransactionId: [\"#{uuid}\"]"
    end
  end

  describe 'when master_account_name' do
    it 'with invalid value' do
      expect { request.master_account_name = Faker::Lorem.word }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      request.master_account_name = value = [Faker::Lorem.word]

      expect(request.build_document).to include "masterAccountName: #{value}"
    end
  end

  describe 'when transaction type' do
    let(:type) do
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
        TransactionTypes.all.sample
    end

    it 'with invalid non-array value' do
      expect { request.transaction_type = type }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid array value' do
      expect { request.transaction_type = [Faker::Internet.uuid] }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      request.transaction_type = [type]

      expect(request.build_document).to include "transactionType: [\"#{type}\"]"
    end
  end

  describe 'when response_fields' do
    let(:field) do
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::ResponseFields.all.sample
    end

    it 'with invalid non-array value' do
      expect { request.response_fields = Faker::Lorem.word }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid array value' do
      expect { request.response_fields = %w(invalid) }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      request            = described_class.new config
      request.unique_id  = [uuid]

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid value' do
      request.response_fields = [field]

      expect(request.build_document).to include "    items\n    {\n      #{field}\n    }"
    end
  end

  describe 'when sort attributes' do
    it 'when sort_by_field with invalid value' do
      request.sort_by_field = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'when sort_by_direction with invalid value' do
      request.sort_by_direction = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'graphql request examples'
  include_examples 'paging attributes examples'
  include_examples 'sort attributes examples', GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::
      BillingApi::OrderByFields.all.sample
  include_examples 'versioned request examples'
end
