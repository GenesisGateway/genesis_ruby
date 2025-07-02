# frozen_string_literal: true

RSpec.shared_examples 'versioned request examples' do
  describe 'when Versioned Request' do
    it 'with version' do
      request.version = 'v1'

      expect(request.api_config['url']).to include '/v1/'
    end

    it 'with allowed_versions' do
      expect(request.allowed_versions).to be_kind_of Array
    end

    it 'with request_path' do
      expect(request.__send__(:request_path)).to_not be_empty
    end
  end
end
