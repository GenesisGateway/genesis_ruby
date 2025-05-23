require 'genesis_ruby/builder'

RSpec.describe GenesisRuby::Builder do
  it 'fail with invalid builder interface' do
    expect { described_class.new('invalid') }.to raise_error(GenesisRuby::BuilderError)
  end

  describe 'XML Builder' do
    let(:xml_builder) { described_class.new(described_class::XML) }

    it 'can generate valid xml content' do
      xml_builder.parse_structure({ root: { element1: 'value1', element2: 'value2' } })
      sample_xml_data = File.open("#{File.dirname(__FILE__)}/fixtures/sample_xml_data.xml", 'rb').read

      expect(xml_builder.document).to eq(sample_xml_data)
    end

    it 'can generate valid xml with attributes' do
      xml_builder.parse_structure({ root: { '@attributes': { attribute1: 'attribute1' }, element1: 'value1' } })
      sample_xml_attributes_data = File.open(
        "#{File.dirname(__FILE__)}/fixtures/sample_xml_attributes_data.xml", 'rb'
      ).read
      expect(xml_builder.document).to eq(sample_xml_attributes_data)
    end

    describe 'can escape illegal characters' do
      let(:builder) do
        xml_builder.parse_structure(
          { root: { amp: 'http://domain.tld/?arg1=normal&arg2=<&arg3=>' } }
        )

        xml_builder
      end

      it 'escape less than' do
        expect(builder.document).to include('&lt;')
      end

      it 'escape greater than' do
        expect(builder.document).to include('&gt;')
      end

      it 'escape an ampersand' do
        expect(builder.document).to include('&amp;')
      end
    end
  end

  describe 'FORM Builder' do
    let(:form_builder) { described_class.new(described_class::FORM) }

    it 'can generate valid form content' do
      form_builder.parse_structure element1: 'value1', element2: 'value2'

      expect(form_builder.document).to eq 'element1=value1&element2=value2'
    end

    describe 'can escape illegal characters' do
      let(:builder) do
        form_builder.parse_structure amp: 'http://domain.tld/?arg1=normal&arg2=<&arg3=>'

        form_builder
      end

      it 'escape less than' do
        expect(builder.document).to include '%3C'
      end

      it 'escape greater than' do
        expect(builder.document).to include '%3E'
      end

      it 'escape an ampersand' do
        expect(builder.document).to include '%26'
      end
    end
  end

  describe 'JSON Builder' do
    let(:json_builder) { described_class.new(described_class::JSON) }

    it 'can generate valid json content' do
      json_builder.parse_structure element1: 'value1', element2: 'value2'

      expect(json_builder.document).to eq "{\n  \"element1\": \"value1\",\n  \"element2\": \"value2\"\n}"
    end
  end

  describe 'Graphql Builder' do
    let(:graphql_builder) { described_class.new(described_class::GRAPHQL) }
    let(:structure) do
      {
        query: {
          action:          'billingTransactions',
          filters:         {
            filter: {
              billingStatement: %w(A123 B456),
              startDate:        '2023-10-03',
              endDate:          '2023-10-05',
              transactionType:  ['Settlement Approved']
            },
            paging: { page: 2, perPage: 3 },
            sort:   { byDirection: 'desc', byField: 'transactionDate' }
          },
          response_fields: {
            items:  %w(billingStatement uniqueId transactionType billingAmount billingCurrency transactionDate),
            paging: %w(page perPage pagesCount totalCount)
          }
        }
      }
    end
    let(:document) do
      File.open("#{File.dirname(__FILE__)}/fixtures/requests/billing_api_request.gql").read.strip
    end

    it 'can generate valid GraphQL content' do
      graphql_builder.parse_structure structure

      expect(graphql_builder.document).to eq document
    end
  end
end
