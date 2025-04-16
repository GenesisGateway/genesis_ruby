require 'spec/genesis_ruby/stubs/api/requests/non_financial/tokenization/tokenization_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Tokenization::TokenizationAttributesStub.new
  end

  describe 'when consumer_id' do
    it 'with setter' do
      expect { attributes.consumer_id = Faker::Internet.uuid[..9] }.to_not raise_error
    end

    it 'with getter' do
      attributes.consumer_id = value = Faker::Internet.uuid[..9]

      expect(attributes.consumer_id).to eq value
    end

    it 'with invalid value' do
      expect { attributes.consumer_id = Faker::Internet.uuid[...12] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when email' do
    it 'with setter' do
      expect { attributes.email = Faker::Internet.email }.to_not raise_error
    end

    it 'with getter' do
      attributes.email = value = Faker::Internet.email

      expect(attributes.email).to eq value
    end

    it 'with invalid value' do
      expect { attributes.email = 'invalid_email' }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when token_type' do
    it 'with setter' do
      expect { attributes.token_type = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      attributes.token_type = value = Faker::Lorem.word

      expect(attributes.token_type).to eq value
    end
  end

  it 'has hash tokenization_attributes_structure' do
    expect(attributes.tokenization_attributes_structure).to be_kind_of(Hash)
  end
end
