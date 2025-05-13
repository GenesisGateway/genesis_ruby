require 'spec/genesis_ruby/stubs/api/requests/financial/source_of_funds_attributes_stub'
require 'genesis_ruby/api/constants/transactions/parameters/source_of_funds'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::SourceOfFundsAttributes do
  let(:source_of_funds_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::SourceOfFundsAttributesStub.new
  end

  describe 'when source_of_funds' do
    let(:valid_source_of_funds) do
      GenesisRuby::Api::Constants::Transactions::Parameters::SourceOfFunds.all.sample
    end

    it 'with setter' do
      expect do
        source_of_funds_attributes.source_of_funds = valid_source_of_funds
      end.to_not raise_error
    end

    it 'with getter' do
      source_of_funds_attributes.source_of_funds = valid_source_of_funds
      expect(source_of_funds_attributes.source_of_funds).to eq(valid_source_of_funds)
    end
  end
end
