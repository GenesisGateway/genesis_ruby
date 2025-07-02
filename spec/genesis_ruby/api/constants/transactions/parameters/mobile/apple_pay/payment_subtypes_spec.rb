# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/mobile/apple_pay/payment_subtypes'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::ApplePay::PaymentSubtypes do

  include_examples 'common constants examples', 'sale'

end
