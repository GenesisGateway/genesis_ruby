RSpec.shared_examples 'tokenization params attributes examples' do

  describe 'when tokenization_tavv attributes' do
    it 'without value' do
      expect(request.build_document).to_not include 'tavv'
    end

    it 'with tokenization_tavv' do
      request.tokenization_tavv = value = Faker::Internet.uuid

      expect(request.build_document).to include "<tavv>#{value}</tavv>"
    end
  end

  describe 'when tokenization_eci attributes' do
    it 'without value' do
      expect(request.build_document).to_not include "<tokenization_params>\n    <eci>"
    end

    it 'with tokenization_eci' do
      request.tokenization_eci = value = Faker::Number.leading_zero_number(digits: 2)

      expect(request.build_document).to include "<tokenization_params>\n    <eci>#{value}</eci>"
    end
  end

end
