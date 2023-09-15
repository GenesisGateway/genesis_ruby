require 'spec/genesis_ruby/stubs/api/requests/financial/cards/recurring/recurring_type_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::Recurring::RecurringTypeAttributes do
  let(:recurring_type_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Cards::Recurring::RecurringTypeAttributesStub.new
  end

  it 'when recurring type accessors with valid value' do
    recurring_type_attributes.recurring_type = 'initial'

    expect(recurring_type_attributes.recurring_type).to eq 'initial'
  end

  it 'when recurring type with invalid value' do
    expect { recurring_type_attributes.recurring_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
  end
end
