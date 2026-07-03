# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/address_document_supported_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::AddressDocumentSupportedTypes do
  include_examples 'common constants examples', described_class::SALARY_SLIP
end
