# frozen_string_literal: true

require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::PurposeOfPayments do
  let(:expected_values) do
    %w(
      family_support
      regular_labor_transfers
      travel_and_tourism
      hospitalization_and_medical_treatment
      emergency_need
      savings
      gifts
      salary
      crowd_lending
      crypto_currency
      refund_to_original_card
      refund_to_new_card
      same_digital_wallet_transfer_to_person_org
      boleto_payment
      high_risk_securities
      recycling_deposit
      vat_payment
      education
      other
    )
  end

  include_examples 'common constants examples', 'family_support'

  it 'contains exactly the expected values' do
    expect(described_class.all).to match_array expected_values
  end
end
