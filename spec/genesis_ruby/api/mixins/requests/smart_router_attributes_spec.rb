# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/smart_router_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::SmartRouterAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::SmartRouterAttributesStub.new }

  describe 'when use_smart_router' do
    it 'with setter' do
      expect { attributes.use_smart_router = Faker::Boolean.boolean }.to_not raise_error
    end

    it 'with getter' do
      attributes.use_smart_router = value = Faker::Boolean.boolean

      expect(attributes.use_smart_router).to eq value
    end

    it 'without value' do
      expect(attributes.use_smart_router).to eq false
    end

    it 'with invalid value' do
      expect { attributes.use_smart_router = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when use_smart_router is true' do
    before do
      allow(attributes).to receive(:use_smart_router).and_return(true)
      allow(attributes).to receive(:init_api_smart_router_configuration)
    end

    it 'calls init_api_smart_router_configuration' do
      attributes.process_request_parameters
      expect(attributes).to have_received(:init_api_smart_router_configuration)
    end
  end

  describe 'when use_smart_router is false' do
    before do
      allow(attributes).to receive(:use_smart_router).and_return(false)
      allow(attributes).to receive(:init_api_smart_router_configuration)
    end

    it 'does not call init_api_smart_router_configuration' do
      attributes.process_request_parameters
      expect(attributes).to_not have_received(:init_api_smart_router_configuration)
    end
  end
end
