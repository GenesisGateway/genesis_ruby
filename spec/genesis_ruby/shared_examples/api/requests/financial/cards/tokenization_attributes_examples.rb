RSpec.shared_examples 'tokenization attributes examples' do
  let(:skip_tokenization_customer_email) { false } unless method_defined? :skip_tokenization_customer_email

  describe 'when token attributes' do
    it 'without token' do
      expect(request.build_document).to_not include 'token'
    end

    it 'with token' do
      request.token       = uuid = Faker::Internet.uuid
      request.consumer_id = Faker::Internet.uuid

      expect(request.build_document).to include "<token>#{uuid}</token>"
    end
  end

  describe 'when remember_card attributes' do
    it 'without remember_card' do
      expect(request.build_document).to_not include 'remember_card'
    end

    it 'with remember_card' do
      request.remember_card = true

      expect(request.build_document).to include '<remember_card>true</remember_card>'
    end

    it 'without customer_email' do
      skip "#{request.class} doesn't support Customer email" if skip_tokenization_customer_email

      request.remember_card  = true
      request.customer_email = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when consumer_id attributes' do
    it 'without consumer_id' do
      expect(request.build_document).to_not include 'consumer_id'
    end

    it 'with consumer_id' do
      request.consumer_id = identifier = Faker::Number.positive

      expect(request.build_document).to include "<consumer_id>#{identifier}</consumer_id>"
    end

    it 'without customer_email' do
      skip "#{request.class} doesn't support Customer email" if skip_tokenization_customer_email

      request.consumer_id    = Faker::Number.positive
      request.customer_email = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
