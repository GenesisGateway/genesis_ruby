RSpec.shared_examples 'document attributes examples' do
  describe 'when document attributes' do
    it 'without document_id' do
      if request.__send__(:required_fields).include?(:document_id)
        skip "#{request.class} has Document Id required attribute!"
      end

      expect(request.build_document).to_not include 'document_id'
    end

    it 'with document_id' do
      request.document_id = document_id = Faker::Internet.uuid

      expect(request.build_document).to include "<document_id>#{document_id}</document_id>"
    end
  end
end
