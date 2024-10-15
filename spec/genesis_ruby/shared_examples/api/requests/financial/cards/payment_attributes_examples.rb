RSpec.shared_examples 'payment attributes examples' do
  describe 'when payment attributes' do
    let(:currency) do
      return request.currency unless request.currency.empty?

      'EUR'
    end
    let(:amount) do
      return request.amount if request.amount

      '0.99'
    end
    let(:minor_amount) do
      return GenesisRuby::Utils::MoneyFormat.amount_to_exponent amount, currency
    end

    it 'with currency' do
      request.currency = currency

      expect(request.build_document).to include "<currency>#{currency}</currency>"
    end

    it 'with amount' do
      request.currency = currency
      request.amount   = amount

      expect(request.build_document).to include "<amount>#{minor_amount}</amount>"
    end
  end
end
