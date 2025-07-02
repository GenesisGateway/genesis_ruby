# frozen_string_literal: true

RSpec.shared_examples 'deposit limits attributes examples' do
  describe 'when deposit limits attributes' do
    let(:deposit_limits) do
      request.payment_method  = GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC # rubocop:disable Layout/LineLength
      request.minimum         = Faker::Number.decimal(l_digits: 2, r_digits: 2)
      request.daily_maximum   = Faker::Number.decimal(l_digits: 3, r_digits: 2)
      request.weekly_maximum  = Faker::Number.decimal(l_digits: 3, r_digits: 2)
      request.monthly_maximum = Faker::Number.decimal(l_digits: 4, r_digits: 2)

      request
    end

    it 'with payment_method' do
      payment_method = GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC # rubocop:disable Layout/LineLength
      deposit_limits.payment_method = payment_method
      expect(deposit_limits.payment_method).to eq payment_method
    end

    it 'with minimum' do
      deposit_limits.minimum = minimum = '10.00'
      expect(deposit_limits.minimum).to eq minimum
    end

    it 'with daily_maximum' do
      deposit_limits.daily_maximum = daily_maximum = '1000.00'
      expect(deposit_limits.daily_maximum).to eq daily_maximum
    end

    it 'with weekly_maximum' do
      deposit_limits.weekly_maximum = weekly_maximum = '5000.00'
      expect(deposit_limits.weekly_maximum).to eq weekly_maximum
    end

    it 'with monthly_maximum' do
      deposit_limits.monthly_maximum = monthly_maximum = '20000.00'
      expect(deposit_limits.monthly_maximum).to eq monthly_maximum
    end

    it 'validates payment_method values' do # rubocop:disable RSpec/ExampleLength
      valid_methods = [
        GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC,
        GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC_OPTIONAL,
        GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_EC
      ]
      expect(GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods.all)
        .to match_array(valid_methods)
    end
  end
end
