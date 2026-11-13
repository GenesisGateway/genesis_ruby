# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/scopes'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes do
  include_examples 'common constants examples', described_class::CARD_NOT_PRESENT
end
