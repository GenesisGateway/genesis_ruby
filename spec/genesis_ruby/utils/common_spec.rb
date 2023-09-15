require 'genesis_ruby/utils/common'
require 'genesis_ruby/api/constants/date_time_formats'

RSpec.describe GenesisRuby::Utils::Common do
  let(:structure) do
    {
      node1: {
        key1: 'value1', key2: nil, key3: ''
      },
      node2: nil,
      node3: [
        {
          key3: 'value3'
        },
        {
          key4: 'value4',
          key5: nil,
          key6: ''
        }
      ],
      node4: '',
      node5: ['', nil, { key7: '' }],
      node6: { key8: nil }
    }
  end

  describe 'can fetch constants' do
    it 'retrieves constant values with given reference' do
      expect(described_class.constant_values(GenesisRuby::Api::Constants::Transactions)).to be_kind_of(Array)
    end

    it 'returns array with constant values' do
      expect(described_class.constant_values(GenesisRuby::Api::Constants::Transactions)).to include('google_pay')
    end
  end

  describe 'when nil values can sanitize tree structure' do
    let(:tree_structure) do
      described_class.deep_compact!(structure)
    end

    it 'removes root node with nil value' do
      expect(tree_structure).to_not include({ node2: nil })
    end

    it 'removes inner key with nil value' do
      expect(tree_structure).to_not include({ node1: { key1: 'value1', key2: nil } })
    end

    it 'removes empty key with nil value when nested array of hashes' do
      expect(tree_structure).to include({ node3: [{ key3: 'value3' }, { key4: 'value4', key6: '' }], node4: '' })
    end

    it 'removes nil values when array' do
      expect(tree_structure).to include node5: ['', { key7: '' }]
    end

    it 'removes sub nodes with nil values' do
      expect(tree_structure).to_not include :node6
    end
  end

  describe 'can validate URL' do
    it 'works with valid URL' do
      expect(described_class.valid_url?(Faker::Internet.url)).to eq(true)
    end

    it 'works with http scheme' do
      expect(described_class.valid_url?(Faker::Internet.url(scheme: 'http'))).to eq(true)
    end

    it 'works with https scheme' do
      expect(described_class.valid_url?(Faker::Internet.url(scheme: 'https'))).to eq(true)
    end

    it 'fails without host URL' do
      expect(described_class.valid_url?(Faker::Internet.url(host: ''))).to eq(false)
    end
  end

  describe 'when empty values can sanitize tree structure' do
    let(:tree_structure) do
      described_class.deep_compact_empty!(structure)
    end

    it 'removes root node with empty value' do
      expect(tree_structure).to_not include(:node4)
    end

    it 'removes root node with nil value' do
      expect(tree_structure).to_not include(:node2)
    end

    it 'removes inner keys with empty and nil values' do
      expect(tree_structure[:node3]).to eq([{ key3: 'value3' }, { key4: 'value4' }])
    end

    it 'removes empty arrays' do
      expect(tree_structure).to_not include(:node5)
    end

    it 'removes empty sub nodes' do
      expect(tree_structure).to_not include :node6
    end
  end

  describe 'can parse date' do
    let(:formats) { GenesisRuby::Api::Constants::DateTimeFormats.all }

    it 'when valid timestamp' do
      expect(described_class.parse_date(Faker::Date.in_date_period.strftime('%Y-%m-%d'), formats)).to be_kind_of Date
    end

    it 'when invalid timestamp' do
      expect(described_class.parse_date(Faker::Date.in_date_period.strftime('%Y-%m'), formats)).to eq(nil)
    end

  end
end
