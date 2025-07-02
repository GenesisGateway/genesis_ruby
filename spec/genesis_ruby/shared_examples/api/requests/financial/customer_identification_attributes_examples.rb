# frozen_string_literal: true

RSpec.shared_examples 'customer identification attributes examples' do
  describe 'when customer identification attributes' do
    it 'with customer_identification_document_id' do
      request.customer_identification_document_id = value = Faker::Alphanumeric.alphanumeric(number: 9)

      expect(request.build_document)
        .to include "<customer_identification>\n    <document_id>#{value}</document_id>\n  </customer_identification>\n"
    end

    it 'with customer_identification_owner' do
      request.customer_identification_owner = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationOwner.all.sample # rubocop:disable Layout/LineLength

      expect(request.build_document)
        .to include "<customer_identification>\n    <owner>#{value}</owner>\n  </customer_identification>\n"
    end

    it 'with customer_identification_type' do
      request.customer_identification_type = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationType.all.sample # rubocop:disable Layout/LineLength

      expect(request.build_document)
        .to include "<customer_identification>\n    <type>#{value}</type>\n  </customer_identification>\n"
    end

    it 'with customer_identification_subtype' do
      request.customer_identification_subtype = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationSubtype.all.sample # rubocop:disable Layout/LineLength

      expect(request.build_document)
        .to include "<customer_identification>\n    <subtype>#{value}</subtype>\n  </customer_identification>\n"
    end

    it 'with customer_identification_issuing_country' do
      request.customer_identification_issuing_country = value = GenesisRuby::Utils::Country::COUNTRIES.keys.sample

      expect(request.build_document)
        .to include "<customer_identification>\n    <issuing_country>#{value}</issuing_country>\n  </customer_identification>\n" # rubocop:disable Layout/LineLength
    end
  end
end
