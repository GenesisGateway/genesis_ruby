RSpec.shared_examples 'reference attributes examples' do
  describe 'when reference attributes' do
    it 'without reference_id' do
      expect(request.build_document).to_not include 'reference_id'
    end

    it 'with reference_id' do
      request.reference_id = reference_id = Faker::Internet.uuid

      expect(request.build_document).to include "<reference_id>#{reference_id}</reference_id>"
    end
  end
end
