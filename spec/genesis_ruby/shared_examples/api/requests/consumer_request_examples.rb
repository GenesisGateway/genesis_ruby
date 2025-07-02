# frozen_string_literal: true

RSpec.shared_examples 'consumer request examples' do |request_name|
  describe 'when Consumer API request' do
    it 'with proper request_path' do
      expect(request.__send__(:request_path)).to eq request_name
    end

    it 'with proper structure' do
      expect(request.build_document).to include "<#{request.__send__(:request_path)}_request>"
    end
  end
end
