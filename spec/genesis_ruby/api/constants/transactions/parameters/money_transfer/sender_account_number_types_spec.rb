# frozen_string_literal: true

require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::SenderAccountNumberTypes do
  let(:expected_values) do
    %w(
      rtn_and_bank_account_number
      iban
      card_account
      email
      phone_number
      bank_account_number_and_bic
      wallet_id
      social_network_id
      other
    )
  end

  include_examples 'common constants examples', 'iban'

  it 'contains exactly the expected values' do
    expect(described_class.all).to match_array expected_values
  end
end
