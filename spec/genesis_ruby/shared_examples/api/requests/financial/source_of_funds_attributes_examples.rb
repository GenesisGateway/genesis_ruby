RSpec.shared_examples 'source of funds attributes examples' do
  describe 'when source of funds attributes' do
    it 'with source_of_funds' do
      request.source_of_funds = value = GenesisRuby::Api::Constants::Transactions::Parameters::SourceOfFunds.all.sample

      expect(request.build_document).to include "<source_of_funds>#{value}</source_of_funds>"
    end
  end
end
