# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/purpose_of_payment'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment do

  include_examples 'common constants examples', 'ISBONU'

  it 'defines 79 purpose of payment codes' do
    expect(described_class.all.size).to eq 79
  end

end
