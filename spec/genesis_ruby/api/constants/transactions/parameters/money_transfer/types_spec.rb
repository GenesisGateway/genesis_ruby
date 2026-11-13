# frozen_string_literal: true

require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::Types do
  let(:expected_values) do
    %w(
      account_to_account
      person_to_person
      wallet_transfer
      funds_transfer
      liquid_assets
      merchant_settlement
      own_account
      own_credit_card_bill
      business_disbursement
      government_or_non_profit_disbursement
      general_business_to_business
    )
  end

  include_examples 'common constants examples', 'account_to_account'

  it 'contains exactly the expected values' do
    expect(described_class.all).to match_array expected_values
  end
end
