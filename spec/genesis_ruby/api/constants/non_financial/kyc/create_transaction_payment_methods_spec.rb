# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/create_transaction_payment_methods'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods do

  include_examples 'common constants examples', described_class::PAYMENT_METHOD_CC

end
