# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/document_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::DocumentAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::DocumentAttributesStub.new }

  describe 'when document_id accessors' do
    it 'with setter' do
      expect { attributes.document_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_id = uuid = Faker::Internet.uuid

      expect(attributes.document_id).to eq uuid
    end
  end
end
