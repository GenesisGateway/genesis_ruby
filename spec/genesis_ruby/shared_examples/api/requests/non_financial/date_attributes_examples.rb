# frozen_string_literal: true

RSpec.shared_examples 'date attributes examples' do
  describe 'when non-financial date attributes' do
    it 'with start_date' do # rubocop:disable RSpec/MultipleExpectations
      if request.api_config.format == 'graphql'
        expect(request.build_document).to_not include "start_date: \"#{request.start_date}\""
      else
        expect(request.build_document).to include "<start_date>#{request.start_date}</start_date>"
      end
    end

    it 'with end_date' do # rubocop:disable RSpec/MultipleExpectations
      if request.api_config.format == 'graphql'
        expect(request.build_document).to include "endDate: \"#{request.end_date}\""
      else
        expect(request.build_document).to include "<end_date>#{request.end_date}</end_date>"
      end
    end
  end
end
