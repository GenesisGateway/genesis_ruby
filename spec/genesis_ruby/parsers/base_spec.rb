RSpec.describe GenesisRuby::Parsers::Base do
  let(:base_parser) { described_class.new }

  it 'has structure method' do
    expect(base_parser.methods).to include(:structure)
  end

  it 'has root_node_skipped method' do
    expect(base_parser.methods).to include(:root_node_skipped)
  end

  it 'has parse_document method' do
    expect(base_parser.methods).to include(:parse_document)
  end

  it 'has default structure value' do
    expect(base_parser.structure).to eq({})
  end

  it 'doesn\'t skip root node with default initialization' do
    expect(base_parser.root_node_skipped).to eq(false)
  end

  it 'skips root node' do
    base_parser.skip_root_node

    expect(base_parser.root_node_skipped).to eq(true)
  end

  it 'fails with parse_document' do
    expect { base_parser.parse_document(nil) }.to raise_error NotImplementedError
  end
end
