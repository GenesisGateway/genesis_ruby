require 'spec/genesis_ruby/stubs/api/requests/financial/cards/fx_rate_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::FxRateAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::FxRateAttributesStub.new }

  describe 'when fx rate id accessors' do
    it 'with setter' do
      expect { attributes.fx_rate_id = Faker::Number.positive.to_i }.to_not raise_error
    end

    it 'with getter' do
      attributes.fx_rate_id = identifier = Faker::Number.positive.to_i

      expect(attributes.fx_rate_id).to eq identifier
    end
  end
end
