# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/transaction_statuses'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::TransactionStatuses do

  include_examples 'common constants examples', described_class::TRANSACTION_STATUS_CHARGEBACK

end
