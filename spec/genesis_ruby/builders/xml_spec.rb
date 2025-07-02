# frozen_string_literal: true

RSpec.describe GenesisRuby::Builders::Xml do
  let(:xml_builder) { described_class.new }

  it 'can generate content' do
    xml_builder.populate_nodes({ root: { element1: 'value1', element2: 'value2' } })
    expect(xml_builder.output).to_not be_empty
  end

  it 'can generate valid xml' do
    xml_builder.populate_nodes({ root: { element1: 'value1', element2: 'value2' } })
    sample_xml_data = File.open("#{File.dirname(__FILE__)}/../fixtures/sample_xml_data.xml", 'rb').read
    expect(xml_builder.output).to eq(sample_xml_data)
  end

  it 'can generate valid xml with attributes' do
    xml_builder.populate_nodes({ root: { '@attributes': { attribute1: 'attribute1' }, element1: 'value1' } })
    sample_xml_attributes_data = File.open(
      "#{File.dirname(__FILE__)}/../fixtures/sample_xml_attributes_data.xml", 'rb'
    ).read
    expect(xml_builder.output).to eq(sample_xml_attributes_data)
  end

  it 'can generate complex structure' do # rubocop:disable RSpec/ExampleLength
    xml_builder.populate_nodes(
      {
        root: {
          travel: {
            '@attributes': { attribute1: 'attribute1' },
            legs:          {
              '@attributes': { attribute1: 'attribute1' },
              leg:           [
                { leg_data: 'data', leg_data1: 'data 1' },
                { leg_data: 'data', leg_data1: 'data 1' },
                { leg_data: 'data', leg_data1: 'data 1' }
              ]
            }
          }
        }
      }
    )

    complex_xml_attributes_data = File.open(
      "#{File.dirname(__FILE__)}/../fixtures/complex_xml_attributes_data.xml", 'rb'
    ).read

    expect(xml_builder.output).to eq complex_xml_attributes_data
  end

  describe 'can escape illegal characters' do
    let(:builder) do
      xml_builder.populate_nodes(
        { root: { amp: 'http://domain.tld/?arg1=normal&arg2=<&arg3=>' } }
      )

      xml_builder
    end

    it 'escape less than' do
      expect(builder.output).to include('&lt;')
    end

    it 'escape greater than' do
      expect(builder.output).to include('&gt;')
    end

    it 'escape an ampersand' do
      expect(builder.output).to include('&amp;')
    end
  end
end
