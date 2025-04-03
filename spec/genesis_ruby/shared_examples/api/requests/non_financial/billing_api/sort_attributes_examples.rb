RSpec.shared_examples 'sort attributes examples' do |allowed_field|
  describe 'when sort attributes' do
    it 'with sort_by_field' do
      request.sort_by_field = allowed_field

      expect(request.build_document).to include "byField: #{allowed_field}"
    end

    it 'with sort_by_direction' do
      request.sort_by_direction = direction = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::
          SortDirections.all.sample

      expect(request.build_document).to include "byDirection: #{direction}"
    end
  end
end
