RSpec.shared_examples 'tokenization api attributes examples' do
  describe 'when tokenization api attributes' do
    it 'with consumer_id' do
      request.consumer_id = value = Faker::Internet.uuid[..9]

      expect(request.build_document).to include "<consumer_id>#{value}</consumer_id>"
    end

    it 'with email' do
      request.email = value = Faker::Internet.email

      expect(request.build_document).to include "<email>#{value}</email>"
    end

    it 'with token_type' do
      request.token_type = value = Faker::Lorem.word

      expect(request.build_document).to include "<token_type>#{value}</token_type>"
    end
  end
end
