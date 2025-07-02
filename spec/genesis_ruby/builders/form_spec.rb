# frozen_string_literal: true

RSpec.describe GenesisRuby::Builders::Form do
  let(:form_builder) { described_class.new }
  let(:data) { { element1: 'value1', element2: 'value2' } }
  let(:document) { 'element1=value1&element2=value2' }

  it 'can generate content' do
    form_builder.populate_nodes data

    expect(form_builder.output).to_not be_empty
  end

  it 'can build proper http query string' do
    form_builder.populate_nodes data

    expect(form_builder.output).to eq document
  end
end
