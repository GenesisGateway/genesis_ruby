require 'spec/genesis_ruby/stubs/api/requests/financial/pending_payment_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::PendingPaymentAttributes do
  let(:pending_payment_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::PendingPaymentAttributesStub.new }

  describe 'has proper return_pending_url accessors' do
    it 'has setter' do
      expect { pending_payment_attributes.return_pending_url = Faker::Internet.url }.to_not raise_error
    end

    it 'has getter' do
      pending_payment_attributes.return_pending_url = url = Faker::Internet.url

      expect(pending_payment_attributes.return_pending_url).to eq(url)
    end
  end

  describe 'has validation' do
    it 'raises with invalid URL' do
      expect do
        pending_payment_attributes.return_pending_url = Faker::Internet.url(host: '')
      end.to raise_error GenesisRuby::ParameterError
    end

    it 'works with valid URL' do
      expect do
        pending_payment_attributes.return_pending_url = Faker::Internet.url
      end.to_not raise_error
    end
  end
end
