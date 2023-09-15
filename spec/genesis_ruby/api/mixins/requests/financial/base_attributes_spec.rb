require 'spec/genesis_ruby/stubs/api/requests/financial/base_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::BaseAttributes do
  let(:base_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::BaseAttributesStub.new }

  describe 'when transaction_id accessors' do
    it 'with setter' do
      expect { base_attributes.transaction_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      base_attributes.transaction_id = identifier = Faker::Internet.uuid

      expect(base_attributes.transaction_id).to eq identifier
    end
  end

  describe 'when usage accessors' do
    it 'with setter' do
      expect { base_attributes.usage = Faker::Lorem.sentence }.to_not raise_error
    end

    it 'with getter' do
      base_attributes.usage = sentence = Faker::Lorem.sentence

      expect(base_attributes.usage).to eq sentence
    end
  end

  describe 'when remote_ip accessors' do
    it 'with setter' do
      expect { base_attributes.remote_ip = Faker::Internet.ip_v4_address }.to_not raise_error
    end

    it 'with getter' do
      base_attributes.remote_ip = ip_address = Faker::Internet.ip_v4_address

      expect(base_attributes.remote_ip).to eq ip_address
    end
  end
end
