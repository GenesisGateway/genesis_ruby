# frozen_string_literal: true

RSpec.shared_examples 'risk attributes examples' do
  describe 'when risk attributes' do
    it 'has proper structure without risk attributes' do
      expect(request.build_document).to_not include 'risk_params'
    end

    it 'has proper structure with risk attributes' do
      request.risk_ssn = Faker::Number.positive

      expect(request.build_document).to include '<risk_params>'
    end
  end
end
