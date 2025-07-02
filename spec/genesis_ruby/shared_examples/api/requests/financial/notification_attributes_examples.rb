# frozen_string_literal: true

RSpec.shared_examples 'notification attributes examples' do
  describe 'when notification attributes' do
    it 'with notification url' do
      request.notification_url = notification_url = Faker::Internet.url

      expect(request.build_document).to include "<notification_url>#{notification_url}</notification_url>"
    end
  end
end
