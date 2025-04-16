require 'spec/genesis_ruby/stubs/api/requests/financial/online_banking_payments/payer_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::OnlineBankingPayments::PayerAttributes do
  let(:payer) do
    GenesisSpec::Stubs::Api::Requests::Financial::OnlineBankingPayments::PayerAttributesStub.new
  end

  describe 'when payer_document_id' do
    it 'with setter' do
      expect { payer.payer_document_id = Faker::Internet.uuid[..15] }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_document_id = identifier = Faker::Internet.uuid[..15]

      expect(payer.payer_document_id).to eq identifier
    end

    it 'with invalid value' do
      expect { payer.payer_document_id = Faker::Internet.uuid[..16] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when payer_bank_code' do
    it 'with setter' do
      expect { payer.payer_bank_code = Faker::Internet.uuid[..11] }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_bank_code = code = Faker::Internet.uuid[..11]

      expect(payer.payer_bank_code).to eq code
    end

    it 'with invalid value' do
      expect { payer.payer_bank_code = Faker::Internet.uuid[..12] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when payer_bank_account_number' do
    it 'with setter' do
      expect { payer.payer_bank_account_number = Faker::Lorem.characters(number: 33) }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_bank_account_number = number = Faker::Lorem.characters(number: 33)

      expect(payer.payer_bank_account_number).to eq number
    end

    it 'with invalid value' do
      expect { payer.payer_bank_account_number = Faker::Lorem.characters(number: 34) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when payer_bank_branch' do
    it 'with setter' do
      expect { payer.payer_bank_branch = Faker::Internet.uuid[..10] }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_bank_branch = branch = Faker::Internet.uuid[..10]

      expect(payer.payer_bank_branch).to eq branch
    end

    it 'with invalid value' do
      expect { payer.payer_bank_branch = Faker::Internet.uuid[..11] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when payer_bank_account_verification_digit' do
    it 'with setter' do
      expect { payer.payer_bank_account_verification_digit = Faker::Lorem.character }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_bank_account_verification_digit = digit = Faker::Lorem.character

      expect(payer.payer_bank_account_verification_digit).to eq digit
    end

    it 'with invalid value' do
      expect { payer.payer_bank_account_verification_digit = Faker::Lorem.characters(number: 2) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when payer_bank_phone_number' do
    it 'with setter' do
      expect { payer.payer_bank_phone_number = Faker::Number.number(digits: 11).to_s }.to_not raise_error
    end

    it 'with getter' do
      payer.payer_bank_phone_number = number = Faker::Number.number(digits: 11).to_s

      expect(payer.payer_bank_phone_number).to eq number
    end

    it 'with invalid value' do
      expect { payer.payer_bank_phone_number = Faker::Number.number(digits: 12).to_s }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

end
