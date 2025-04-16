RSpec.shared_examples 'payer attributes examples' do
  describe 'when beneficiary attributes' do
    describe 'when payer_document_id' do
      it 'with valid value' do
        request.payer_document_id = value = Faker::Internet.uuid[..15]

        expect(request.build_document).to include "<payer>\n    <document_id>#{value}</document_id>\n  </payer>"
      end

      it 'without assignment' do
        request.document_id = Faker::Lorem.characters number: 10

        expect(request.build_document).to_not include '<payer>\n    <document_id>'
      end
    end

    describe 'when payer_bank_code' do
      it 'with valid value' do
        request.payer_bank_code = value = Faker::Internet.uuid[..11]

        expect(request.build_document).to include "<payer>\n    <bank_code>#{value}</bank_code>\n  </payer>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include "<payer>\n    <bank_code>"
      end
    end

    describe 'when payer_bank_account_number' do
      it 'with valid value' do
        request.payer_bank_account_number = value = Faker::Lorem.characters(number: 33)

        expect(request.build_document)
          .to include "<payer>\n    <bank_account_number>#{value}</bank_account_number>\n  </payer>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include "<payer>\n    <bank_account_number>"
      end
    end

    describe 'when payer_bank_branch' do
      it 'with valid value' do
        request.payer_bank_branch = value = Faker::Internet.uuid[..10]

        expect(request.build_document).to include "<payer>\n    <bank_branch>#{value}</bank_branch>\n  </payer>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include "<payer>\n    <bank_branch>"
      end
    end

    describe 'when payer_bank_account_verification_digit' do
      # rubocop:disable Layout/LineLength
      it 'with valid value' do
        request.payer_bank_account_verification_digit = value = Faker::Lorem.character

        expect(request.build_document)
          .to include "<payer>\n    <bank_account_verification_digit>#{value}</bank_account_verification_digit>\n  </payer>"
      end
      # rubocop:enable Layout/LineLength

      it 'without assignment' do
        expect(request.build_document).to_not include "<payer>\n    <bank_account_verification_digit>"
      end
    end

    describe 'when payer_bank_phone_number' do
      it 'with valid value' do
        request.payer_bank_phone_number = value = Faker::Number.number(digits: 11).to_s

        expect(request.build_document)
          .to include "<payer>\n    <bank_phone_number>#{value}</bank_phone_number>\n  </payer>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include "<payer>\n    <bank_phone_number>"
      end
    end
  end
end
