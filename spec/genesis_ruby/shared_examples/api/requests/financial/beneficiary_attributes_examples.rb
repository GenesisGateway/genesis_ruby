RSpec.shared_examples 'beneficiary attributes examples' do
  describe 'when beneficiary attributes' do
    it 'with beneficiary_name' do
      request.beneficiary_name = name = Faker::Name.name

      expect(request.build_document).to include "<beneficiary>\n    <name>#{name}</name>\n  </beneficiary>\n"
    end

    it 'with beneficiary_document_id' do
      request.beneficiary_document_id = identifier = Faker::Internet.uuid[..13]

      expect(request.build_document)
        .to include "<beneficiary>\n    <document_id>#{identifier}</document_id>\n  </beneficiary>\n"
    end

    it 'with beneficiary_pix_key' do
      request.beneficiary_pix_key = key = Faker::Lorem.characters(number: 36)

      expect(request.build_document)
        .to include "<beneficiary>\n    <pix_key>#{key}</pix_key>\n  </beneficiary>\n"
    end
  end
end
