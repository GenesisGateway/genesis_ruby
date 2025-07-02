# frozen_string_literal: true

RSpec.shared_examples 'fx rate attributes examples' do
  describe 'when fx rate attributes' do
    it 'without fx_rate_id' do
      expect(request.build_document).to_not include 'fx_rate_id'
    end

    it 'with reference_id' do
      request.fx_rate_id = identifier = Faker::Number.positive

      expect(request.build_document).to include "<fx_rate_id>#{identifier}</fx_rate_id>"
    end
  end
end
