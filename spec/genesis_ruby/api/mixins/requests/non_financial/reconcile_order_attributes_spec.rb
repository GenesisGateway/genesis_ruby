# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/reconcile_order_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::ReconcileOrderAttributes do
  let(:order_id) { Faker::Alphanumeric.alphanumeric number: 20 }
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::ReconcileOrderAttributesStub.new }

  describe 'when order_id accessors' do
    it 'with setter' do
      expect { attributes.order_id = order_id }.to_not raise_error
    end

    it 'with getter' do
      attributes.order_id = order_id
      expect(attributes.order_id).to eq order_id
    end
  end

  describe 'when order_id' do
    it 'with 255 characters' do
      expect { attributes.order_id = 'a' * 255 }.to_not raise_error
    end

    it 'with 256 characters' do
      expect { attributes.order_id = 'a' * 256 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with nil value' do
      expect { attributes.order_id = nil }.to_not raise_error
    end

    it 'with empty value' do
      expect { attributes.order_id = '' }.to_not raise_error
    end

    it 'with nil value after a valid value' do
      attributes.order_id = order_id
      attributes.order_id = nil
      expect(attributes.order_id).to be_nil
    end
  end
end
