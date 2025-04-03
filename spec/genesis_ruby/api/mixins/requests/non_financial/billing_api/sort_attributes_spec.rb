require 'spec/genesis_ruby/stubs/api/requests/non_financial/billing_api/sort_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::BillingApi::SortAttributes do
  let(:sort_attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::BillingApi::SortAttributesStub.new }

  describe 'when sort_by_field' do
    it 'with setter' do
      expect { sort_attributes.sort_by_field = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      sort_attributes.sort_by_field = field = Faker::Lorem.word

      expect(sort_attributes.sort_by_field).to eq field
    end
  end

  describe 'when sort_by_direction' do
    it 'with setter' do
      expect { sort_attributes.sort_by_direction = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      sort_attributes.sort_by_direction = direction = Faker::Lorem.word

      expect(sort_attributes.sort_by_direction).to eq direction
    end
  end
end
