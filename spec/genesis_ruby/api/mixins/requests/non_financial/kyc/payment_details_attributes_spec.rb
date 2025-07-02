# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/payment_details_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::PaymentDetailsAttributes do
  let(:payment_details) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::PaymentDetailsAttributesStub.new
  end

  let(:details_attributes) do
    {
      bin:         Faker::Number.number(digits: 6).to_s,
      tail:        Faker::Number.number(digits: 4).to_s,
      cvv_present: Faker::Boolean.boolean,
      hashed_pan:  Faker::Crypto.md5,
      routing:     Faker::Bank.routing_number,
      account:     Faker::Bank.account_number,
      ewallet_id:  Faker::Internet.uuid
    }
  end

  describe 'payment details structure' do
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      payment_details.bin         = details_attributes[:bin]
      payment_details.tail        = details_attributes[:tail]
      payment_details.cvv_present = details_attributes[:cvv_present]
      payment_details.hashed_pan  = details_attributes[:hashed_pan]
      payment_details.routing     = details_attributes[:routing]
      payment_details.account     = details_attributes[:account]
      payment_details.ewallet_id  = details_attributes[:ewallet_id]

      expected_hash = {
        bin:         details_attributes[:bin],
        tail:        details_attributes[:tail],
        cvv_present: details_attributes[:cvv_present],
        hashed_pan:  details_attributes[:hashed_pan],
        routing:     details_attributes[:routing],
        account:     details_attributes[:account],
        ewallet_id:  details_attributes[:ewallet_id]
      }

      structure = payment_details.payment_details_structure
      expect(structure).to eq(expected_hash)
    end
  end
end
