RSpec.describe GenesisRuby::Parsers::Json do
  let(:json_parser) { described_class.new }
  let(:fixtures_path) { "#{File.dirname(File.dirname(__FILE__))}/fixtures" }

  describe 'when invalid JSON document' do
    it 'with empty document' do
      expect { json_parser.parse_document('') }.to raise_error GenesisRuby::ParserError
    end

    it 'with nil document' do
      expect { json_parser.parse_document(nil) }.to raise_error GenesisRuby::ParserError
    end
  end

  describe 'when valid document' do
    let(:response) do
      json_parser.parse_document File.open("#{fixtures_path}/responses/billing_api_response.json", 'rb').read

      json_parser.structure
    end

    it 'with root node' do
      json_parser.skip_root_node # JSON parsers ignores root node removal

      expect(response).to include(:data)
    end

    it 'with attributes' do
      expect(response[:data][:billingTransactions][:paging][:page]).to eq 1
    end

    it 'with element with Array value' do
      expect(response[:data][:billingTransactions][:items]).to be_kind_of Array
    end

    it 'with element with Array items' do
      expect(response[:data][:billingTransactions][:items].length).to eq 6
    end

    it 'with element with Hash item' do
      expect(response[:data][:billingTransactions][:items][0]).to be_kind_of Hash
    end

    it 'with element with Hash item with value' do
      expect(response[:data][:billingTransactions][:items][0][:billingCurrency]).to eq 'GBP'
    end
  end
end
