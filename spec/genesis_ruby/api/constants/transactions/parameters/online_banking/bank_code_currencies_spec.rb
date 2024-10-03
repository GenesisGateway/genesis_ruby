require 'genesis_ruby/api/constants/transactions/parameters/online_banking/bank_code_currencies'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies do
  let(:currency) { described_class.all.sample }

  include_examples 'common constants examples', 'eur'

  it 'when allowed currencies with non strict validation' do
    expect(described_class.valid?(currency.upcase)).to be true
  end

  it 'when bank codes with currency' do
    expect(described_class.bank_codes_per_currency(currency.upcase)).to be_kind_of Array
  end
end
