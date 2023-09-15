require 'spec/genesis_ruby/stubs/utils/formatters/base_stub'

RSpec.describe GenesisRuby::Utils::Formatters::Base do
  let(:base_formatter) { described_class.new }
  let(:structure) { { key1: 'value1', key2: 'value2', key3: 'value3' } }
  let(:formatter_stub) { GenesisSpec::Stubs::Utils::Formatters::BaseStub.new }

  it 'has response_keys' do
    expect(base_formatter.formatting_keys).to eq([])
  end

  it 'has required_keys' do
    expect(base_formatter.required_keys).to eq([])
  end

  it 'has format_key' do
    expect { base_formatter.format_key }.to raise_error NotImplementedError
  end

  describe 'without required keys' do
    it 'has required keys collector' do
      expect(base_formatter.collect_required_key_values(structure)).to eq([])
    end
  end

  describe 'with required keys' do
    it 'collects required keys' do
      expect(formatter_stub.collect_required_key_values(structure)).to eq(%w(value1 value2))
    end
  end
end
