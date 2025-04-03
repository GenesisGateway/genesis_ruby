RSpec.describe GenesisRuby::Utils::Formatters::Response::Formats::Timestamp do
  let(:timestamp_format) { described_class.new }

  it 'has formatting_keys' do
    expect(timestamp_format.formatting_keys).to eq %w(timestamp transactionDate valueDate)
  end

  it 'has no required_keys' do
    expect(timestamp_format.required_keys).to eq([])
  end

  it 'formats timestamp with valid timestamp' do
    expect(timestamp_format.format_key('2023-04-06T07:32:30Z')).to be_kind_of DateTime
  end

  it 'works with invalid timestamp' do
    expect(timestamp_format.format_key('invalid')).to eq('invalid')
  end

end
