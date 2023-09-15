require 'genesis_ruby/builder'

RSpec.describe GenesisRuby::Builder do
  it 'fail with invalid builder interface' do
    expect { described_class.new('invalid') }.to raise_error(GenesisRuby::BuilderError)
  end

  describe 'XML Builder' do
    let(:xml_builder) { described_class.new(GenesisRuby::Builder::XML) }

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
end
