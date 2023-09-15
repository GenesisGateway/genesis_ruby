RSpec.describe GenesisRuby::Utils::Formatters::Response::Formats::Amount do
  let(:amount_format) { described_class.new }

  it 'has formatting_keys' do
    expect(amount_format.formatting_keys).to eq(%w(amount leftover_amount))
  end

  it 'has required_keys' do
    expect(amount_format.required_keys).to eq(%w(currency))
  end

  it 'formats currency with valid exponent' do
    expect(amount_format.format_key('99', 'EUR')).to eq('0.99')
  end

  it 'works with invalid exponent' do
    expect(amount_format.format_key('0.999', 'EUR')).to eq('0.999')
  end

  it 'works with invalid amount' do
    expect(amount_format.format_key('invalid', 'EUR')).to eq('invalid')
  end
end
