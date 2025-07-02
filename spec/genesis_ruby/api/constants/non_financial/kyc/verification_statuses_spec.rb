# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/verification_statuses'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::VerificationStatuses do

  include_examples 'common constants examples', described_class::VERIFICATION_FAILED

end
