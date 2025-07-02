# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/online_banking/payment_types'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::PaymentTypes do
  include_examples 'common constants examples', 'qr_payment'
end
