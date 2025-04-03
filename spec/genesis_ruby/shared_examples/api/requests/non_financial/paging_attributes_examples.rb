RSpec.shared_examples 'paging attributes examples' do
  describe 'when paging attributes' do
    describe 'when page attribute' do
      it 'without page' do
        expect(request.build_document).to_not include 'page: '
      end

      it 'with page' do
        request.page = '1'

        expect(request.build_document).to include "page: #{request.page.to_i}"
      end
    end

    describe 'when per_page attribute' do
      it 'without per_page' do
        expect(request.build_document).to_not include 'perPage: '
      end

      it 'with per_page' do
        request.per_page = '1'

        expect(request.build_document).to include "perPage: #{request.per_page.to_i}"
      end
    end
  end
end
