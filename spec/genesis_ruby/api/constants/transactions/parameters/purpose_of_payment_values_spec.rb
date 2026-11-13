# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/purpose_of_payment_values'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPaymentValues do

  include_examples 'common constants examples', 'bonus_payment'

  it 'defines 81 purpose of payment values' do
    expect(described_class.all.size).to eq 81
  end

end
