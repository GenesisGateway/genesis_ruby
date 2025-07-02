# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/online_banking/bank_codes'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::BankCodes do
  include_examples 'common constants examples', 'VTCP_ABBANK'
end
