# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/document_supported_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes do

  include_examples 'common constants examples', described_class::CREDIT_OR_DEBIT_CARD

end
