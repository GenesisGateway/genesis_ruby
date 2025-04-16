require 'spec/genesis_ruby/stubs/api/requests/non_financial/tokenization/token_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Tokenization::TokenAttributesStub.new
  end

  describe 'when token' do
    it 'with setter' do
      expect { attributes.token = Faker::Lorem.characters(number: 36) }.to_not raise_error
    end

    it 'with getter' do
      attributes.token = value = Faker::Lorem.characters(number: 36)

      expect(attributes.token).to eq value
    end

    it 'with invalid value' do
      expect { attributes.token = Faker::Lorem.characters(number: 38) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
