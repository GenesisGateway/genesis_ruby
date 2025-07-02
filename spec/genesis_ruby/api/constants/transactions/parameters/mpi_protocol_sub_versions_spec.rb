# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/mpi_protocol_sub_versions'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::MpiProtocolSubVersions do

  include_examples 'common constants examples', 9

end
