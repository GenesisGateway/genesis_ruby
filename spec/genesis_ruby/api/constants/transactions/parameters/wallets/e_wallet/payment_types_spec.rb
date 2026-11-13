# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/wallets/e_wallet/payment_types'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::PaymentTypes do

  include_examples 'common constants examples', 'Paytm'

  it 'contains all eWallet payment types' do
    expect(described_class.all).to match_array(
      ['Airtel Money', 'Amazon pay', 'Free Charge', 'Jio Money', 'Ola Money', 'Paytm', 'Payzapp', 'PhonePe']
    )
  end

end
