RSpec.shared_examples 'preauthorization attributes examples' do

  describe 'when preauthorization attributes' do

    it 'with preauthorization' do
      request.preauthorization = true

      expect(request.build_document).to include '<preauthorization>true</preauthorization>'
    end

    it 'with preauthorization with invalid value' do
      expect { request.preauthorization = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

  end
end
