# frozen_string_literal: true

RSpec.describe GenesisRuby::Utils::Formatters::Response::Loader do
  let(:loader) { described_class.new }

  it 'has response format definitions' do
    expect(described_class.include?(GenesisRuby::Utils::Formatters::Response)).to eq(true)
  end

  it 'initializes response formatters' do
    expect(loader.formats).to_not be_empty
  end
end
