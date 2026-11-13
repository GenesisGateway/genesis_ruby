# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/force_threeds_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::ForceThreedsAttributes do
  let(:request) { GenesisSpec::Stubs::Api::Requests::Financial::Threeds::ForceThreedsAttributesStub.new }

  describe 'when initialized' do
    it 'has nil force_threeds' do
      expect(request.force_threeds).to be_nil
    end
  end

  describe 'when valid values' do
    [true, false].each do |value|
      it "stores #{value}" do
        request.force_threeds = value

        expect(request.force_threeds).to eq value
      end
    end

    [nil, ''].each do |value|
      it "stores nil when #{value.inspect} is assigned" do
        request.force_threeds = true
        request.force_threeds = value

        expect(request.force_threeds).to be_nil
      end
    end
  end

  describe 'when invalid values' do
    ['true', 'false', '1', '0', 1, 0, :true, :false].each do |value| # rubocop:disable Lint/BooleanSymbol
      it "raises error for #{value.inspect}" do
        expect { request.force_threeds = value }.to raise_error GenesisRuby::InvalidArgumentError, /boolean/
      end

    end

    context 'with previously assigned value' do
      before { request.force_threeds = false }

      ['true', 'false', '1', '0', 1, 0, :true, :false].each do |value| # rubocop:disable Lint/BooleanSymbol
        it "preserves the previous value for #{value.inspect}" do
          request.force_threeds = value
        rescue GenesisRuby::InvalidArgumentError
          expect(request.force_threeds).to be false
        else
          raise 'Expected GenesisRuby::InvalidArgumentError'
        end
      end
    end
  end
end
