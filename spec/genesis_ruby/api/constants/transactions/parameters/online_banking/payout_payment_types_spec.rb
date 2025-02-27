require 'genesis_ruby/api/constants/transactions/parameters/online_banking/payout_payment_types'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::PayoutPaymentTypes do
  include_examples 'common constants examples', 'pix_b2b'
end
