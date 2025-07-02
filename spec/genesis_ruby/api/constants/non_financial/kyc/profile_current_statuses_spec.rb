# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/profile_current_statuses'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::ProfileCurrentStatuses do

  include_examples 'common constants examples', described_class::APPROVED

end
