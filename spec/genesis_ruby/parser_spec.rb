require 'genesis_ruby/parser'

RSpec.describe GenesisRuby::Parser do
  it 'fail with invalid parser interface' do
    expect { described_class.new('invalid') }.to raise_error(GenesisRuby::ParserError)
  end

  describe 'XML Parser' do
    let(:parser) { described_class.new(GenesisRuby::Parser::XML) }
    let(:payment_response) do
      File.open("#{File.dirname(__FILE__)}/fixtures/responses/gate_authorize_payment_response.xml", 'rb').read
    end

    it 'parses valid document' do
      expect { parser.parse_document payment_response }.to_not raise_error
    end

    it 'has Hash structure' do
      parser.parse_document(payment_response)

      expect(parser.structure).to be_kind_of Hash
    end

    it 'has root node' do
      parser.parse_document(payment_response)

      expect(parser.structure[:payment_response]).to_not be_kind_of NilClass
    end

    it 'skips root node' do
      parser.skip_root_node
      parser.parse_document(payment_response)

      expect(parser.structure[:payment_response]).to be_kind_of NilClass
    end

    describe 'with valid payment response' do
      let(:structure) do
        parser.skip_root_node
        parser.parse_document(payment_response)

        parser.structure
      end

      it 'contains transaction_type' do
        expect(structure[:transaction_type]).to eq('authorize3d')
      end

      it 'contains status' do
        expect(structure[:status]).to eq('approved')
      end

      it 'contains amount' do
        expect(structure[:amount]).to eq('5000')
      end

      it 'contains timestamp' do
        expect(structure[:timestamp]).to eq('2023-04-04T18:45:22Z')
      end

      it 'contains mode' do
        expect(structure[:mode]).to eq('live')
      end

      it 'contains sent_to_acquirer' do
        expect(structure[:sent_to_acquirer]).to eq('true')
      end
    end

    describe 'with valid wpf response' do
      let(:structure) do
        parser.skip_root_node
        parser.parse_document(
          File.open("#{File.dirname(__FILE__)}/fixtures/responses/gate_wpf_payment.xml", 'rb').read
        )

        parser.structure
      end

      it 'contains status' do
        expect(structure[:status]).to eq('new')
      end

      it 'contains amount' do
        expect(structure[:amount]).to eq('99')
      end

      it 'contains currency' do
        expect(structure[:currency]).to eq('EUR')
      end
    end

    describe 'with invalid document' do
      it 'fails with invalid document' do
        document = '<?xml><root><test>true</test></root>'

        expect { parser.parse_document(document) }.to raise_error GenesisRuby::ParserError
      end

      it 'fails with empty document' do
        expect { parser.parse_document(nil) }.to raise_error GenesisRuby::ParserError
      end
    end
  end

end
