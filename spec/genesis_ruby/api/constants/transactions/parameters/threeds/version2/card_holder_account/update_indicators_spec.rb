# frozen_string_literal: true

# rubocop:disable Layout/LineLength
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/update_indicators'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::UpdateIndicators do

  include_examples 'common constants examples', 'less_than_30days'

end
# rubocop:enable Layout/LineLength
