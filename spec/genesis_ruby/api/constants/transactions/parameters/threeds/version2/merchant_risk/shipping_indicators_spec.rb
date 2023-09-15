# rubocop:disable Layout/LineLength
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/merchant_risk/shipping_indicators'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::MerchantRisk::ShippingIndicators do

  include_examples 'common constants examples', 'same_as_billing'

end
# rubocop:enable Layout/LineLength
