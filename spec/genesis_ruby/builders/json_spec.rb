# frozen_string_literal: true

require 'json'

RSpec.describe GenesisRuby::Builders::Json do
  let(:json_builder) { described_class.new }

  it 'can generate content' do
    json_builder.populate_nodes({ root: { element1: 'value1', element2: 'value2' } })
    expect(json_builder.output).to_not be_empty
  end

  it 'can generate valid json' do
    json_builder.populate_nodes({ root: { element1: 'value1', element2: 'value2' } })
    sample_json_data = File.open("#{File.dirname(__FILE__)}/../fixtures/sample_json_data.json", 'rb').read
    expect(json_builder.output).to eq(sample_json_data.strip)
  end

  it 'when invalid JSON with handled errors' do
    expect { json_builder.populate_nodes(JSON::NaN) }.to raise_error GenesisRuby::BuilderError
  end

  it 'with complex structure' do # rubocop:disable RSpec/ExampleLength
    json_builder.populate_nodes(
      {
        data: {
          innerData: {
            items:  [
              {
                uniqueId:     'abc123',
                integerValue: 10_001,
                stringValue:  'stmt-0001',
                booleanValue: true
              },
              {
                uniqueId:     'abc123',
                integerValue: 10_001,
                stringValue:  'stmt-0001',
                booleanValue: true
              }
            ],
            paging: { page: 1, perPage: 2, pagesCount: 7, totalCount: 13 }
          }
        }
      }
    )

    complex_xml_attributes_data = File.open(
      "#{File.dirname(__FILE__)}/../fixtures/complex_json_attributes_data.json", 'rb'
    ).read

    expect(json_builder.output).to eq complex_xml_attributes_data.strip
  end

  describe 'can escape characters' do
    let(:builder) do
      json_builder.populate_nodes(
        { root: { amp: '12\12\12' } }
      )

      json_builder
    end

    it 'escape slash than' do
      expect(builder.output).to include('12\\\12\\\12')
    end
  end
end
