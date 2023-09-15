RSpec.shared_examples 'gaming attributes examples' do
  describe 'when gaming attributes' do
    it 'without gaming attributes' do
      expect(request.build_document).to_not include 'gaming'
    end

    it 'with gaming attributes' do
      request.gaming = true

      expect(request.build_document).to include '<gaming>true</gaming>'
    end
  end
end
