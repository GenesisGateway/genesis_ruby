# frozen_string_literal: true

RSpec.shared_examples 'pending attributes examples' do
  describe 'when pending attributes' do
    it 'with pending url' do
      request.return_pending_url = pending_url = Faker::Internet.url

      expect(request.build_document).to include "<return_pending_url>#{pending_url}</return_pending_url>"
    end
  end
end
