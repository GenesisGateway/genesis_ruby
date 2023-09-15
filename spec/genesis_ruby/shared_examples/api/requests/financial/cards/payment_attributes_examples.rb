RSpec.shared_examples 'payment attributes examples' do
  describe 'when payment attributes' do
    it 'with currency' do
      request.currency = currency = 'EUR'

      expect(request.build_document).to include "<currency>#{currency}</currency>"
    end

    it 'with amount' do
      request.currency = 'EUR'
      request.amount   = '0.99'

      expect(request.build_document).to include '<amount>99</amount>'
    end
  end
end
