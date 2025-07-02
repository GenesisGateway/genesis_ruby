# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/recurring/categories'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Categories do

  include_examples 'common constants examples', 'standing_order'

end
