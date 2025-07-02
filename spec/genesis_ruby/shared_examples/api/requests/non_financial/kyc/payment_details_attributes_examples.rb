# frozen_string_literal: true

RSpec.shared_examples 'payment details attributes examples' do
  describe 'when payment details attributes' do
    let(:payment_details) do
      request.bin         = Faker::Number.number(digits: 6).to_s
      request.tail        = Faker::Number.number(digits: 4).to_s
      request.cvv_present = Faker::Boolean.boolean
      request.hashed_pan  = Faker::Crypto.md5
      request.routing     = Faker::Bank.routing_number
      request.account     = Faker::Bank.account_number
      request.ewallet_id  = Faker::Internet.uuid

      request
    end

    it 'with bin' do
      payment_details.bin = bin = '411111'
      expect(payment_details.bin).to eq bin
    end

    it 'with tail' do
      payment_details.tail = tail = '1111'
      expect(payment_details.tail).to eq tail
    end

    it 'with cvv_present' do
      payment_details.cvv_present = cvv_present = true
      expect(payment_details.cvv_present).to eq cvv_present
    end

    it 'with hashed_pan' do
      payment_details.hashed_pan = hashed_pan = Faker::Crypto.sha256
      expect(payment_details.hashed_pan).to eq hashed_pan
    end

    it 'with routing' do
      payment_details.routing = routing = '123456789'
      expect(payment_details.routing).to eq routing
    end

    it 'with account' do
      payment_details.account = account = '987654321'
      expect(payment_details.account).to eq account
    end

    it 'with ewallet_id' do
      payment_details.ewallet_id = ewallet_id = SecureRandom.uuid
      expect(payment_details.ewallet_id).to eq ewallet_id
    end
  end
end
