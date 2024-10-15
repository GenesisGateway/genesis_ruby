RSpec.shared_examples 'consumer identifier attributes examples' do
  describe 'when consumer identifier attributes' do
    it 'with consumer_reference' do
      request.consumer_reference = reference = Faker::Internet.uuid[..19]

      expect(request.build_document).to include "<consumer_reference>#{reference}</consumer_reference>"
    end

    it 'with national_id' do
      request.national_id = identifier = Faker::Internet.uuid[..19]

      expect(request.build_document).to include "<national_id>#{identifier}</national_id>"
    end
  end
end
