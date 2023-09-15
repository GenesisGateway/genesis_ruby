RSpec.shared_examples 'moto attributes examples' do
  describe 'when moto attributes' do
    it 'without moto attributes' do
      expect(request.build_document).to_not include 'moto'
    end

    it 'with moto attributes' do
      request.moto = true

      expect(request.build_document).to include '<moto>true</moto>'
    end
  end
end
