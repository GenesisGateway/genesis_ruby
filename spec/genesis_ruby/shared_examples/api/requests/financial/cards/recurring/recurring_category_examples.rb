RSpec.shared_examples 'recurring category examples' do
  describe 'when recurring category' do
    it 'with valid value' do
      request.recurring_category = category =
        GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Categories::SUBSCRIPTION

      expect(request.recurring_category).to eq category
    end

    it 'with invalid recurring category' do
      expect { request.recurring_category = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'has proper structure without recurring category' do
      expect(request.build_document).to_not include 'recurring_category'
    end

    it 'has proper structure with recurring category' do
      request.recurring_category = type =
        GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Categories::STANDING_ORDER

      expect(request.build_document).to include "<recurring_category>#{type}</recurring_category>"
    end

    it 'can unset recurring category' do
      request.recurring_category = ''

      expect(request.build_document).to_not include 'recurring_category'
    end
  end
end
