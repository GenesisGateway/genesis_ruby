# frozen_string_literal: true

RSpec.shared_examples 'customer account attributes examples' do
  describe 'when customer account attributes' do
    it 'with customer_account_id' do
      request.customer_account_id = id = Faker::Lorem.characters(number: 20)

      expect(request.build_document).to include "<customer_account_id>#{id}</customer_account_id>"
    end
  end
end
