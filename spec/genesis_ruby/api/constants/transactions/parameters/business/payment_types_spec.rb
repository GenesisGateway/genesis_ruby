require 'genesis_ruby/api/constants/transactions/parameters/business/payment_types'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Business::PaymentTypes do

  include_examples 'common constants examples', 'deposit'

end
