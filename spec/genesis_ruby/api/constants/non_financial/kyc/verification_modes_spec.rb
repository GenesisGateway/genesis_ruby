# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/verification_modes'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::VerificationModes do

  include_examples 'common constants examples', described_class::IMAGE_ONLY

end
