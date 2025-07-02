# frozen_string_literal: true

require 'genesis_ruby/utils/threeds/v2'

RSpec.describe GenesisRuby::Utils::Threeds::V2 do

  it 'when generate signature' do # rubocop:disable RSpec/ExampleLength
    unique_id = Faker::Internet.uuid
    amount    = 10.00
    timestamp = Faker::Date.between(from: '1990-01-01', to: '2040-12-31')
    password  = 'password'

    signature = Digest::SHA512.hexdigest "#{unique_id}#{amount}#{timestamp}#{password}"

    expect(described_class.generate_signature(
             unique_id: unique_id, amount: amount, timestamp: timestamp, merchant_password: password
           )).to eq signature
  end

end
