# frozen_string_literal: true

RSpec.shared_examples 'paging attributes examples' do
  describe 'when paging attributes' do
    describe 'when page attribute' do
      it 'without page' do
        expect(request.build_document).to_not include 'page: '
      end

      it 'with page' do
        request.page = '1'

        expectation = "<page>#{request.page.to_i}</page>"
        expectation = "page: #{request.page.to_i}" if request.api_config.format == 'graphql'

        expect(request.build_document).to include expectation
      end
    end

    describe 'when per_page attribute' do
      it 'without per_page' do
        expect(request.build_document).to_not include 'perPage: '
      end

      it 'with per_page' do
        request.per_page = '1'

        expectation = "<per_page>#{request.per_page.to_i}</per_page>"
        expectation = "perPage: #{request.per_page.to_i}" if request.api_config.format == 'graphql'

        expect(request.build_document).to include expectation
      end
    end
  end
end
