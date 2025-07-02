# frozen_string_literal: true

RSpec.shared_examples 'ucof attributes examples' do
  describe 'when credential_on_file_transaction_identifier' do
    it 'without value' do
      expect(request.build_document).to_not include 'credential_on_file_transaction_identifier'
    end

    it 'with valid value' do
      request.credential_on_file_transaction_identifier = identifier = Faker::Internet.uuid[..31]

      expect(request.build_document).to(
        include("<credential_on_file_transaction_identifier>#{identifier}</credential_on_file_transaction_identifier>")
      )
    end

    it 'with invalid value' do
      expect { request.credential_on_file_transaction_identifier = Faker::Internet.uuid[..10] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when credential_on_file_settlement_date' do
    it 'without value' do
      expect(request.build_document).to_not include 'credential_on_file_settlement_date'
    end

    it 'with valid value' do
      request.credential_on_file_settlement_date = date = '1231'

      expect(request.build_document)
        .to include "<credential_on_file_settlement_date>#{date}</credential_on_file_settlement_date>"
    end

    it 'with invalid value' do
      expect { request.credential_on_file_settlement_date = '1131' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
