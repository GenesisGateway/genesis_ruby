require 'spec/genesis_ruby/stubs/api/requests/financial/african_mobile_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::AfricanMobileAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::AfricanMobileAttributesStub.new }
  let(:operator) { GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators.all.sample }

  describe 'when target' do
    it 'with setter' do
      expect { attributes.target = Faker::Lorem.characters(number: 20) }.to_not raise_error
    end

    it 'with getter' do
      attributes.target = value = Faker::Lorem.characters(number: 20)

      expect(attributes.target).to eq value
    end

    it 'with invalid long value' do
      expect do
        attributes.target = Faker::Lorem.characters(number: 21)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when operator' do
    it 'with setter' do
      expect { attributes.operator = operator }.to_not raise_error
    end

    it 'with getter' do
      attributes.operator = operator

      expect(attributes.operator).to eq operator
    end

    it 'with lowercase value' do
      expect { attributes.operator = operator.downcase }.to_not raise_error
    end
  end
end
