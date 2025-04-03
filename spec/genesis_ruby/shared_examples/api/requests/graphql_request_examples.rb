RSpec.shared_examples 'graphql request examples' do
  describe 'when GraphQL Request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to_not be_empty
    end

    it 'with root_key' do
      expect(request.__send__(:root_key)).to_not be_empty
    end

    it 'with request_name' do
      expect(request.__send__(:request_name)).to_not be_empty
    end

    it 'with init_authorization_token' do
      expect { request.__send__(:init_authorization_token) }.to_not raise_error
    end

    it 'with query_filters' do
      expect(request.__send__(:query_filters)).to be_kind_of Hash
    end

    it 'with query_response_fields' do
      expect(request.__send__(:query_response_fields)).to be_kind_of Hash
    end
  end
end
