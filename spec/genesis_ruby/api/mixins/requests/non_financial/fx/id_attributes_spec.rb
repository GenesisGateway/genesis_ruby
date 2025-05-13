require 'spec/genesis_ruby/stubs/api/requests/non_financial/fx/id_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Fx::IdAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Fx::IdAttributesStub.new
  end

  describe 'when id' do
    it 'with setter' do
      expect { attributes.id = Faker::Lorem.characters(number: 5) }.to_not raise_error
    end

    it 'with getter' do
      attributes.id = value = Faker::Lorem.characters(number: 5)

      expect(attributes.id).to eq value
    end

    it 'with integer value' do
      attributes.id = 12_345

      expect(attributes.id).to eq 12_345.to_s
    end
  end
end
