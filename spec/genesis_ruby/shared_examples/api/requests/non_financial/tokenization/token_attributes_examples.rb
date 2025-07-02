# frozen_string_literal: true

RSpec.shared_examples 'token attributes examples' do
  describe 'when token' do
    it 'with value' do
      request.token = value = Faker::Lorem.characters(number: 36)

      expect(request.build_document).to include "<token>#{value}</token>"
    end
  end
end
