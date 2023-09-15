# rubocop:disable Layout/LineLength
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/control/challenge_window_sizes'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::ChallengeWindowSizes do

  include_examples 'common constants examples', '250x400'

end
# rubocop:enable Layout/LineLength
