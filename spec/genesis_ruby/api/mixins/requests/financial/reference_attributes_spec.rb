# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/reference_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::ReferenceAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::ReferenceAttributesStub.new }

  describe 'when reference_id accessors' do
    it 'with setter' do
      expect { attributes.reference_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      attributes.reference_id = uuid = Faker::Internet.uuid

      expect(attributes.reference_id).to eq uuid
    end
  end
end
