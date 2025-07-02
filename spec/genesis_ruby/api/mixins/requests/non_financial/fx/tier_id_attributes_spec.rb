# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/fx/tier_id_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Fx::TierIdAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Fx::TierIdAttributesStub.new
  end

  describe 'when tier id' do
    it 'with setter' do
      expect { attributes.tier_id = Faker::Lorem.characters(number: 5) }.to_not raise_error
    end

    it 'with getter' do
      attributes.tier_id = value = Faker::Lorem.characters(number: 5)

      expect(attributes.tier_id).to eq value
    end

    it 'with integer value' do
      attributes.tier_id = 12_345

      expect(attributes.tier_id).to eq 12_345.to_s
    end
  end
end
