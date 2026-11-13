# frozen_string_literal: true

require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::SourceOfFunds do
  let(:expected_values) do
    %w(
      credit
      debit
      prepaid
      cash
      deposit_account
    )
  end

  include_examples 'common constants examples', 'credit'

  it 'contains exactly the expected values' do
    expect(described_class.all).to match_array expected_values
  end
end
