# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/aml_filters'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::AmlFilters do

  include_examples 'common constants examples', described_class::ADVERSE_MEDIA_V2_NARCOTICS_AML_CFT

end
