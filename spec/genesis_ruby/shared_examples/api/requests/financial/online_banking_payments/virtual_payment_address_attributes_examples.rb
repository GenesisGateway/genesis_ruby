RSpec.shared_examples 'virtual payment address attributes examples' do
  describe 'when virtual payment address attributes' do
    it 'without virtual payment address attributes' do
      expect(request.build_document).to_not include 'virtual_payment_address'
    end

    it 'with virtual payment address attributes' do
      request.virtual_payment_address = 'someone@bank'

      expect(request.build_document).to include '<virtual_payment_address>someone@bank</virtual_payment_address>'
    end
  end
end
