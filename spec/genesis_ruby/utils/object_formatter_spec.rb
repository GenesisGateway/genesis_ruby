# frozen_string_literal: true

RSpec.describe GenesisRuby::Utils::ObjectFormatter do
  let(:structure) do
    parser = GenesisRuby::Parser.new(GenesisRuby::Parser::XML)
    parser.skip_root_node

    parser.parse_document(
      File.open("#{File.dirname(File.dirname(__FILE__))}/fixtures/responses/reconcile_wpf.xml")
    )
  end
  let(:object_formatter) { described_class.new }
  let(:response_formatter) { GenesisRuby::Utils::Formatters::Response::Loader.new }

  describe 'without formatters' do
    it 'works without error' do
      expect { object_formatter.format_structure(structure) }.to_not raise_error
    end

    it 'doesn\'t modify the structure' do
      expect(object_formatter.format_structure(structure)).to eq(structure)
    end

    it 'appends many formatters' do
      object_formatter.formats = response_formatter.formats
      object_formatter.formats = ['Formatter']

      expect(object_formatter.formats).to include('Formatter')
    end

    it 'has empty array with formatters' do
      expect(object_formatter.formats).to eq([])
    end

    it 'raises error with invalid type when formatter' do
      expect do
        object_formatter.formats = response_formatter.formats.sample
      end.to raise_error GenesisRuby::ObjectFormatterError
    end
  end

  describe 'with response formatter' do
    before do
      object_formatter.formats = response_formatter.formats
    end

    let(:formatted_structure) { object_formatter.format_structure(structure) }

    it 'has array with formatters' do
      expect(object_formatter.formats).to eq(response_formatter.formats)
    end

    it 'format currency when root node' do
      expect(formatted_structure[:amount]).to eq('18.10')
    end

    it 'format timestamp when root node' do
      expect(formatted_structure[:timestamp]).to be_kind_of DateTime
    end

    it 'formats currency when inner node' do
      expect(formatted_structure[:payment_transaction].first[:amount]).to eq('18.10')
    end

    it 'formats timestamp when inner node' do
      expect(formatted_structure[:payment_transaction].first[:timestamp]).to be_kind_of DateTime
    end

    it 'formats more than one key' do
      modified_structure = object_formatter.format_structure(structure.merge({ leftover_amount: '99' }))

      expect(modified_structure[:leftover_amount]).to eq('0.99')
    end

    describe 'when structure not meet formatter requirements' do
      let(:invalid_structure) { { amount: '1810', timestamp: 'invalid' } }

      it 'works with structure'  do
        expect { object_formatter.format_structure(invalid_structure) }.to_not raise_error
      end

      it 'returns amount untouched' do
        expect(object_formatter.format_structure(invalid_structure)[:amount]).to eq('1810')
      end

      it 'returns timestamp untouched' do
        expect(object_formatter.format_structure(invalid_structure)[:timestamp]).to eq('invalid')
      end

    end
  end

end
