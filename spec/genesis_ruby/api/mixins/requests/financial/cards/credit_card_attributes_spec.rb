require 'spec/genesis_ruby/stubs/api/requests/financial/cards/credit_card_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::CreditCardAttributes do
  let(:credit_card) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::CreditCardAttributesStub.new }

  describe 'when card_holder accessors' do
    it 'with setter' do
      expect { credit_card.card_holder = Faker::Name.name_with_middle }.to_not raise_error
    end

    it 'with getter' do
      credit_card.card_holder = full_name = Faker::Name.name_with_middle

      expect(credit_card.card_holder).to eq full_name
    end
  end

  describe 'when card_number accessors' do
    it 'with setter' do
      expect { credit_card.card_number = Faker::Finance.credit_card }.to_not raise_error
    end

    it 'with getter' do
      credit_card.card_number = card_number = Faker::Finance.credit_card

      expect(credit_card.card_number).to eq card_number
    end
  end

  describe 'when expiration_month accessors' do
    it 'with setter' do
      expect { credit_card.expiration_month = Faker::Date.in_date_period.strftime('%m') }.to_not raise_error
    end

    it 'with getter' do
      credit_card.expiration_month = month = Faker::Date.in_date_period.strftime('%m')

      expect(credit_card.expiration_month).to eq month
    end
  end

  describe 'when expiration_year accessors' do
    it 'with setter' do
      expect { credit_card.expiration_year = Faker::Date.in_date_period.strftime('%Y') }.to_not raise_error
    end

    it 'with getter' do
      credit_card.expiration_year = year = Faker::Date.in_date_period.strftime('%Y')

      expect(credit_card.expiration_year).to eq year
    end
  end

  describe 'when cvv accessors' do
    it 'with setter' do
      expect { credit_card.cvv = Faker::Number.positive from: 100, to: 999 }.to_not raise_error
    end

    it 'with getter' do
      credit_card.cvv = cvv = Faker::Number.positive from: 100, to: 999

      expect(credit_card.cvv).to eq cvv
    end
  end

  it 'when credit card attributes structure' do
    expect(credit_card.credit_card_attributes_structure).to be_kind_of Hash
  end
end
