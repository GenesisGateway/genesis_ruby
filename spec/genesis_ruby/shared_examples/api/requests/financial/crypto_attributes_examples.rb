RSpec.shared_examples 'crypto attributes examples' do
  describe 'when crypto attributes' do
    it 'without crypto attributes' do
      expect(request.build_document).to_not include 'crypto'
    end

    it 'with crypto attributes' do
      request.crypto = true

      expect(request.build_document).to include '<crypto>true</crypto>'
    end
  end
end
