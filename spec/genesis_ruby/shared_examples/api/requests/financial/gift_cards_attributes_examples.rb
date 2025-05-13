RSpec.shared_examples 'gift cards attributes examples' do
  describe 'when gift cards attributes' do
    it 'with card_number' do
      request.card_number = value = Faker::Number.number(digits: 21).to_s

      expect(request.build_document).to include "<card_number>#{value}</card_number>"
    end

    it 'with cvv' do
      request.cvv = value = Faker::Number.number(digits: 5).to_s

      expect(request.build_document)
        .to include "<cvv>#{value}</cvv>"
    end
  end
end
