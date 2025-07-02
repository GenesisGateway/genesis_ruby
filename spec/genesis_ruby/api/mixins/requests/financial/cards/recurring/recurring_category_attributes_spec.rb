# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/recurring/recurring_category_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::RecurringCategoryAttributes do
  let(:recurring_category_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Cards::Recurring::RecurringCategoryAttributesStub.new
  end

  it 'when recurring category accessors with valid value' do
    recurring_category_attributes.recurring_category = category = 'subscription'

    expect(recurring_category_attributes.recurring_category).to eq category
  end

  it 'when recurring type with invalid value' do
    expect do
      recurring_category_attributes.recurring_category = 'invalid'
    end.to raise_error GenesisRuby::InvalidArgumentError
  end
end
