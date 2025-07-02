# frozen_string_literal: true

RSpec.shared_examples 'common constants examples' do |valid_value|

  it 'works when all constant values' do
    expect(described_class.all).to be_kind_of Array
  end

  it 'works when validates' do
    expect(described_class.valid?(valid_value, strict: true)).to eq(true)
  end

end
