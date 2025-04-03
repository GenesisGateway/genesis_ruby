RSpec.describe GenesisRuby::Builders::Graphql do
  let(:graphql_builder) { described_class.new }
  let(:data) do
    {
      query: {
        action:          'exampleAction',
        filters:         {
          filter: { key1: 'value1', key2: 'value2', key3: ['some value', 'other value'] },
          sort:   { byDirection: 'desc', byField: 'key2' },
          paging: { page: 1, perPage: 2 }
        },
        response_fields: { items: %w(item1 item2 item3), paging: %w(page perPage pagesCount totalCount) }
      }
    }
  end
  let(:document) do
    File.open("#{File.dirname(__FILE__)}/../fixtures/requests/fake_graphql_request.gql").read.strip
  end

  it 'when generate content' do
    graphql_builder.populate_nodes(data)

    expect(graphql_builder.output).to_not be_empty
  end

  it 'when GraphQL document' do
    graphql_builder.populate_nodes(data)

    expect(graphql_builder.output).to eq document
  end

  it 'when GraphQL document with empty structure' do
    data[:query][:action]  = ''
    data[:query][:filters] = {}
    data[:query][:response_fields] = {}
    graphql_builder.populate_nodes(data)

    expect(graphql_builder.output).to eq "query {\n  ()\n  {\n\n  }\n}"
  end
end
