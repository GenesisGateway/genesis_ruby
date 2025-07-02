# frozen_string_literal: true

RSpec.shared_examples 'async attributes examples' do
  describe 'when async attributes' do
    it 'with return_success_url' do
      request.return_success_url = success_url = Faker::Internet.url

      expect(request.build_document).to include "<return_success_url>#{success_url}</return_success_url>"
    end

    it 'with return_failure_url' do
      request.return_failure_url = failure_url = Faker::Internet.url

      expect(request.build_document).to include "<return_failure_url>#{failure_url}</return_failure_url>"
    end
  end
end
