require 'genesis_ruby/api/constants/transactions/parameters/sca_exemptions'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions do

  include_examples 'common constants examples', 'low_value'

end
