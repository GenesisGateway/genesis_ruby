require 'spec/genesis_ruby/stubs/api/requests/non_financial/tokenization/card_data_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::CardDataAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Tokenization::CardDataAttributesStub.new
  end
  let(:credit_card_number) { '1234567890123456789' }

  describe 'when card_holder' do
    it 'with setter' do
      expect { attributes.card_holder = Faker::Address.name }.to_not raise_error
    end

    it 'with getter' do
      attributes.card_holder = value = Faker::Address.name

      expect(attributes.card_holder).to eq value
    end
  end

  describe 'when card_number' do
    it 'with setter' do
      expect { attributes.card_number = credit_card_number }.to_not raise_error
    end

    it 'with getter' do
      attributes.card_number = credit_card_number

      expect(attributes.card_number).to eq credit_card_number
    end

    it 'with invalid short value' do
      expect { attributes.card_number = '1234' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid long value' do
      expect { attributes.card_number = Faker::Lorem.characters(number: 20) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when expiration_month' do
    it 'with setter' do
      expect { attributes.expiration_month = Faker::Date.in_date_period.strftime('%m') }.to_not raise_error
    end

    it 'with getter' do
      attributes.expiration_month = month = Faker::Date.in_date_period.strftime('%m')

      expect(attributes.expiration_month).to eq month
    end

    it 'with invalid value' do
      expect { attributes.expiration_month = '99' }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when expiration_year' do
    it 'with setter' do
      expect { attributes.expiration_year = Faker::Date.in_date_period.strftime('%Y') }.to_not raise_error
    end

    it 'with getter' do
      attributes.expiration_year = year = Faker::Date.in_date_period.strftime('%Y')

      expect(attributes.expiration_year).to eq year
    end

    it 'with invalid value' do
      expect { attributes.expiration_month = '1234' }.to raise_error GenesisRuby::ParameterError
    end
  end

  it 'has hash card_data_attributes_structure' do
    expect(attributes.card_data_attributes_structure).to be_kind_of(Hash)
  end
end
