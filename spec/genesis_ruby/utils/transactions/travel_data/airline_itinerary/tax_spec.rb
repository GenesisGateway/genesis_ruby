require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/tax'

RSpec.describe GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Tax do
  let(:tax) { described_class.new }
  let(:amount) { Faker::Number.decimal l_digits: 2, r_digits: 2 }
  let(:type) { Faker::String.random length: 8 }

  describe 'when attributes structure' do
    it 'with hash type' do
      expect(tax.attributes_structure).to be_kind_of Hash
    end

    it 'with initialized attributes' do
      tax = described_class.new fee_amount: 0.99, fee_type: 'type'

      expect(tax.attributes_structure).to be_kind_of Hash
    end
  end

  describe 'when fee amount' do
    it 'with setter' do
      expect { tax.fee_amount = amount }.to_not raise_error
    end

    it 'with getter' do
      tax.fee_amount = amount

      expect(tax.fee_amount).to eq amount
    end

    it 'with currency' do
      tax.fee_amount = amount
      tax.currency   = 'EUR'

      expect(tax.attributes_structure)
        .to eq fee_amount: GenesisRuby::Utils::MoneyFormat.amount_to_exponent(amount, tax.currency), fee_type: nil
    end
  end

  describe 'with fee type' do
    it 'with valid data setter' do
      expect { tax.fee_type = type }.to_not raise_error
    end

    it 'with invalid data setter' do
      expect { tax.fee_type = Faker::String.random }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      tax.fee_type = type

      expect(tax.fee_type).to eq type
    end
  end
end
