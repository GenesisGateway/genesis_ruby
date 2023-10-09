RSpec.shared_examples 'financial attributes examples' do
  describe 'when financial XML document' do
    it 'with root element' do
      expect(request.build_document).to include '<payment_transaction>'
    end

    it 'with transaction type' do
      expect(request.build_document)
        .to include "<transaction_type>#{request.__send__(:transaction_type)}</transaction_type>"
    end

    it 'with transaction_id' do
      expect(request.build_document).to include "<transaction_id>#{request.transaction_id}</transaction_id>"
    end

    it 'with usage' do
      expect(request.build_document).to include "<usage>#{request.usage}</usage>"
    end

    it 'with remote_ip' do
      expect(request.build_document).to include "<remote_ip>#{request.remote_ip}</remote_ip>"
    end
  end
end
