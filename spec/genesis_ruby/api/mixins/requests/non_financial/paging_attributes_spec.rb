# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/paging_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::PagingAttributes do
  let(:paging_attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::PagingAttributesStub.new }

  it 'when paging query response fields' do
    expect(paging_attributes.__send__(:paging_query_fields)).to be_kind_of Array
  end

  describe 'when page attribute' do
    it 'with setter' do
      expect { paging_attributes.page = Faker::Number.number(digits: 1) }.to_not raise_error
    end

    it 'with getter' do
      paging_attributes.page = number = Faker::Number.number(digits: 1)

      expect(paging_attributes.page).to eq number
    end

    it 'with integer value' do
      paging_attributes.page = '1'

      expect(paging_attributes.page).to be_kind_of Integer
    end
  end

  describe 'when per_page attribute' do
    it 'with setter' do
      expect { paging_attributes.per_page = Faker::Number.number(digits: 1) }.to_not raise_error
    end

    it 'with getter' do
      paging_attributes.per_page = number = Faker::Number.number(digits: 1)

      expect(paging_attributes.per_page).to eq number
    end

    it 'with integer value' do
      paging_attributes.per_page = '1'

      expect(paging_attributes.per_page).to be_kind_of Integer
    end
  end
end
