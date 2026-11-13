# frozen_string_literal: true

# Shared behavior identical across the standard Statement (billingStatements) and the
# EnhancedStatement (enhancedBillingStatements) requests (R3.12). The including spec provides
# a +config+ let and a +request+ let built from the concrete described_class with
# response_fields = ['id'] (valid for both the standard and enhanced field sets).
RSpec.shared_examples 'abstract statement examples' do
  let(:abstract_base) { GenesisRuby::Api::Requests::Base::NonFinancial::BillingApi::AbstractStatement }
  let(:max_billing_statement) { abstract_base::MAX_COUNT_BILLING_STATEMENT }
  let(:max_master_account_mid) { abstract_base::MAX_COUNT_MASTER_ACCOUNT_MID }

  describe 'when filters present in the generated query' do
    it 'with currency rendered quoted and upper-cased' do
      request.currency = 'usd'

      expect(request.build_document).to include 'currency: "USD"'
    end

    it 'with invalid currency raises ParameterError' do
      request.currency = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with status rendered without quotes' do
      request.status = status = abstract_base::STATUSES.first

      expect(request.build_document).to include "status: #{status}"
    end

    it 'with invalid status raises ParameterError' do
      request.status = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with payment_method rendered quoted' do
      request.payment_method = method = 'credit_card'

      expect(request.build_document).to include "paymentMethod: \"#{method}\""
    end

    it 'with creation_date rendered quoted' do
      request.creation_date = '1970-01-01'

      expect(request.build_document).to include 'creationDate: "1970-01-01"'
    end

    it 'with billing_statement rendered as a list literal' do
      request.billing_statement = value = %w(bs-1 bs-2)

      expect(request.build_document).to include "billingStatement: [\"#{value[0]}\",\"#{value[1]}\"]"
    end

    it 'with master_account_mid rendered as a list literal' do
      request.master_account_mid = value = %w(mid-1 mid-2)

      expect(request.build_document).to include "masterAccountMID: [\"#{value[0]}\",\"#{value[1]}\"]"
    end
  end

  describe 'when billing_statement array size' do
    it 'with exactly the max count is accepted' do
      request.billing_statement = Array.new(max_billing_statement, 'x')

      expect { request.build_document }.to_not raise_error
    end

    it 'when exceeding the max count raises ParameterError' do
      request.billing_statement = Array.new(max_billing_statement + 1, 'x')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when master_account_mid array size' do
    it 'with exactly the max count is accepted' do
      request.master_account_mid = Array.new(max_master_account_mid, 'x')

      expect { request.build_document }.to_not raise_error
    end

    it 'when exceeding the max count raises ParameterError' do
      request.master_account_mid = Array.new(max_master_account_mid + 1, 'x')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when cursor paging' do
    # Paging alone is not a filter (R2.8), so a filter is set to allow a valid build
    before { request.currency = 'USD' }

    it 'with per_page rendered as a bare numeric value' do
      request.per_page = 100

      expect(request.build_document).to include 'perPage: 100'
    end

    it 'with next cursor rendered quoted' do
      request.next = cursor = 'cursor-token'

      expect(request.build_document).to include "next: \"#{cursor}\""
    end
  end

  describe 'when sort' do
    let(:order_by_field) do
      GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::StatementOrderByFields.all.sample
    end

    # Sort alone is not a filter (R2.8), so a filter is set to allow a valid build
    before { request.currency = 'USD' }

    it 'with sort_by_field from the allowed set rendered without quotes' do
      request.sort_by_field = order_by_field

      expect(request.build_document).to include "byField: #{order_by_field}"
    end

    it 'with sort_by_direction from the allowed set rendered without quotes' do
      request.sort_by_direction = direction = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::
          SortDirections.all.sample

      expect(request.build_document).to include "byDirection: #{direction}"
    end

    it 'with invalid sort_by_field raises ParameterError' do
      request.sort_by_field = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when no filter set' do
    it 'raises ParameterError' do
      request                 = described_class.new config
      request.response_fields = ['id']

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  # The single-date start_date / end_date filters are not part of the statement API contract (R1.8)
  describe 'when deprecated start_date / end_date filters' do
    %i[start_date start_date= end_date end_date=].each do |method_name|
      it "does not respond to #{method_name}" do
        expect(request).to_not respond_to method_name
      end
    end
  end
end
