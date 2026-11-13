# frozen_string_literal: true

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

  context 'when rendering response-field selections' do
    it 'when flat field name renders as a leaf without braces' do
      data[:query][:response_fields] = { items: %w(leafOne leafTwo) }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to include "    items\n    {\n      leafOne\n      leafTwo\n    }"
    end

    it 'when flat leaf does not emit a sub-selection brace' do
      data[:query][:response_fields] = { items: %w(leafOne) }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to_not include "leafOne\n      {"
    end

    it 'when single-key hash renders name followed by recursive sub-selection' do
      data[:query][:response_fields] = { items: [{ 'summary' => %w(count amount) }] }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to include "      summary\n      {\n        count\n        amount\n      }"
    end

    it 'when mixed flat and nested selection renders both correctly' do
      data[:query][:response_fields] = { items: ['status', { 'summary' => %w(count) }] }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to include "      status\n      summary\n      {\n        count\n      }"
    end

    it 'when selection preserves the nesting order supplied by the caller' do
      data[:query][:response_fields] = { items: [{ 'summary' => %w(gross net) }] }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output.index('gross')).to be < graphql_builder.output.index('net')
    end
  end

  context 'when rendering deeply nested response-field selections' do
    let(:deep_document) do
      File.open("#{File.dirname(__FILE__)}/../fixtures/requests/deep_nested_graphql_request.gql").read.strip
    end
    let(:deep_data) do
      nest = { 'level1' => [{ 'level2' => [{ 'level3' => [{ 'level4' => [{ 'level5' => %w(deepLeaf) }] }] }] }] }

      {
        query: {
          action:          'exampleAction',
          filters:         { filter: { key1: 'value1' } },
          response_fields: {
            items:  ['topLeaf', nest],
            paging: %w(page perPage)
          }
        }
      }
    end

    it 'when document matches the deep-nesting fixture' do
      graphql_builder.populate_nodes(deep_data)

      expect(graphql_builder.output).to eq deep_document
    end

    it 'when every nested level name is rendered' do
      graphql_builder.populate_nodes(deep_data)

      %w(level1 level2 level3 level4 level5 deepLeaf).each do |name|
        expect(graphql_builder.output).to include name
      end
    end

    it 'when the deepest leaf is rendered deeper than the shallowest level' do
      graphql_builder.populate_nodes(deep_data)

      level1_indent = graphql_builder.output[/^(\s*)level1$/, 1]
      leaf_indent   = graphql_builder.output[/^(\s*)deepLeaf$/, 1]

      expect(leaf_indent.length).to be > level1_indent.length
    end
  end

  context 'when a nested name has an empty sub-selection' do
    it 'when raising a BuilderError' do
      data[:query][:response_fields] = { items: [{ 'summary' => [] }] }

      expect { graphql_builder.populate_nodes(data) }.to raise_error GenesisRuby::BuilderError
    end

    it 'when the error message identifies the offending nested name' do
      data[:query][:response_fields] = { items: [{ 'summary' => [] }] }

      expect { graphql_builder.populate_nodes(data) }.to raise_error(GenesisRuby::BuilderError, /summary/)
    end
  end

  context 'when omitting empty filter arguments' do
    it 'when empty scalar argument is omitted from the output' do
      data[:query][:filters] = { filter: { key1: '', key2: 'value2' } }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to_not include 'key1'
    end

    it 'when empty array argument is omitted from the output' do
      data[:query][:filters] = { filter: { key1: [], key2: 'value2' } }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to_not include 'key1'
    end

    it 'when the remaining argument is still rendered' do
      data[:query][:filters] = { filter: { key1: '', key2: 'value2' } }
      graphql_builder.populate_nodes(data)

      expect(graphql_builder.output).to include 'key2: "value2"'
    end
  end

  # Task 11.3 - representative summary/details-shaped deep nested selection mirroring the
  # enhanced-statement example tree from the design document (R7.1, R7.2, R7.3, R6.5, R6.7, R10.8)
  context 'when rendering the enhanced-statement summary/details selection' do
    let(:enhanced_selection) do
      [
        'billingStatement',
        'status',
        { 'summary' => [
          { 'grossVolume' => %w(count amount) },
          'netSettlementAmount',
          'paymentAmount'
        ] },
        { 'details' => [
          { 'discountFees' => [
            'subtotalCount',
            'subtotalValue',
            'subtotalAmount',
            { 'feesByRegionAndCardType' => [
              'category',
              { 'feesByTransactionType' => %w(transactionType count value amount rate interchange) }
            ] }
          ] }
        ] }
      ]
    end

    let(:supplied_names) do
      %w(
        billingStatement status summary grossVolume count amount netSettlementAmount paymentAmount
        details discountFees subtotalCount subtotalValue subtotalAmount feesByRegionAndCardType category
        feesByTransactionType transactionType value rate interchange
      )
    end

    before do
      data[:query][:response_fields] = { items: enhanced_selection }
      graphql_builder.populate_nodes(data)
    end

    it 'when every supplied name across all nesting levels is rendered' do
      supplied_names.each { |name| expect(graphql_builder.output).to include name }
    end

    it 'when flat top-level leaves render without a sub-selection brace' do
      expect(graphql_builder.output).to_not include "status\n      {"
    end

    it 'when the summary nested name renders with a recursive sub-selection' do
      expect(graphql_builder.output).to include "      summary\n      {"
    end

    it 'when the grossVolume sub-selection renders its leaves in the supplied order' do
      expect(graphql_builder.output.index('count')).to be < graphql_builder.output.index('amount')
    end

    it 'when the top-level selection order summary-before-details is preserved' do
      expect(graphql_builder.output.index('summary')).to be < graphql_builder.output.index('details')
    end

    it 'when the deepest feesByTransactionType leaf is nested deeper than its parent group' do
      region_indent = graphql_builder.output[/^(\s*)feesByRegionAndCardType$/, 1]
      leaf_indent   = graphql_builder.output[/^(\s*)transactionType$/, 1]

      expect(leaf_indent.length).to be > region_indent.length
    end

    it 'when feesByRegionAndCardType is rendered before its category leaf' do
      output = graphql_builder.output

      expect(output.index('feesByRegionAndCardType')).to be < output.index('category')
    end

    it 'when category is rendered before the nested feesByTransactionType group' do
      output = graphql_builder.output

      expect(output.index('category')).to be < output.index('feesByTransactionType')
    end

    it 'when feesByTransactionType is rendered before its transactionType leaf' do
      output = graphql_builder.output

      expect(output.index('feesByTransactionType')).to be < output.index('transactionType')
    end
  end
end
