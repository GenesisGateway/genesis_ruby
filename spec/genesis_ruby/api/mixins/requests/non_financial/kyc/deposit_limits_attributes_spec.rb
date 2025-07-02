# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/deposit_limits_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::DepositLimitsAttributes do
  let(:deposit_limit) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::DepositLimitsAttributesStub.new
  end

  let(:deposit_limit_attributes) do
    {
      payment_method:  GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods.all.sample,
      minimum:         Faker::Number.between(from: 100, to: 500),
      daily_maximum:   Faker::Number.between(from: 1000, to: 5000),
      weekly_maximum:  Faker::Number.between(from: 5000, to: 20_000).to_s,
      monthly_maximum: Faker::Number.between(from: 20_000, to: 100_000).to_s
    }
  end

  describe 'deposit limits structure' do
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      deposit_limit.payment_method  = deposit_limit_attributes[:payment_method]
      deposit_limit.minimum         = deposit_limit_attributes[:minimum]
      deposit_limit.daily_maximum   = deposit_limit_attributes[:daily_maximum]
      deposit_limit.weekly_maximum  = deposit_limit_attributes[:weekly_maximum]
      deposit_limit.monthly_maximum = deposit_limit_attributes[:monthly_maximum]

      expected_hash = {
        payment_method:  deposit_limit_attributes[:payment_method],
        minimum:         deposit_limit_attributes[:minimum],
        daily_maximum:   deposit_limit_attributes[:daily_maximum],
        weekly_maximum:  deposit_limit_attributes[:weekly_maximum],
        monthly_maximum: deposit_limit_attributes[:monthly_maximum]
      }

      structure = deposit_limit.public_send(:deposit_limits_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
