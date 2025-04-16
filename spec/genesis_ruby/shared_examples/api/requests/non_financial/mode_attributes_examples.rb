RSpec.shared_examples 'mode attributes examples' do
  describe 'when mode attributes' do
    it 'with valid value' do
      request.mode = 'list'

      expect(request.build_document).to include '<mode>list</mode>'
    end

    it 'with invalid value' do
      expect { request.mode = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end
end
