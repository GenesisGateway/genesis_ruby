# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/order_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::OrderAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::OrderAttributesStub.new }
  let(:max_length) { described_class::ORDER_ID_MAX_LENGTH }
  let(:order_id) { "ORD-#{Faker::Number.number(digits: 8)}" }

  describe 'when order_id' do
    it 'has max length constant' do
      expect(max_length).to eq 255
    end

    it 'is nil by default' do
      expect(attributes.order_id).to be_nil
    end

    it 'with setter' do
      expect { attributes.order_id = order_id }.to_not raise_error
    end

    it 'with getter' do
      attributes.order_id = order_id

      expect(attributes.order_id).to eq order_id
    end

    it 'stores non-string value as string' do
      attributes.order_id = 78_456

      expect(attributes.order_id).to eq '78456'
    end

    it 'clears value with nil' do
      attributes.order_id = order_id
      attributes.order_id = nil

      expect(attributes.order_id).to be_nil
    end

    it 'clears value with empty string' do
      attributes.order_id = order_id
      attributes.order_id = ''

      expect(attributes.order_id).to be_nil
    end

    it 'accepts value with max length' do
      value = 'a' * max_length
      attributes.order_id = value

      expect(attributes.order_id).to eq value
    end

    it 'accepts multibyte value with max length' do
      value = 'я' * max_length
      attributes.order_id = value

      expect(attributes.order_id).to eq value
    end

    it 'raises error with value over max length' do
      expect { attributes.order_id = 'a' * (max_length + 1) }.to raise_error GenesisRuby::InvalidArgumentError
    end

    describe 'with invalid assignment after valid value' do
      before do
        attributes.order_id = order_id

        begin
          attributes.order_id = 'a' * (max_length + 1)
        rescue GenesisRuby::InvalidArgumentError
          nil
        end
      end

      it 'keeps previous value' do
        expect(attributes.order_id).to eq order_id
      end
    end
  end

  describe 'when order attributes structure' do
    it 'returns hash' do
      expect(attributes.order_attributes_structure).to be_a Hash
    end

    it 'contains order_id' do
      attributes.order_id = order_id

      expect(attributes.order_attributes_structure).to eq(order_id: order_id)
    end

    it 'contains nil order_id when unset' do
      expect(attributes.order_attributes_structure).to eq(order_id: nil)
    end
  end
end
