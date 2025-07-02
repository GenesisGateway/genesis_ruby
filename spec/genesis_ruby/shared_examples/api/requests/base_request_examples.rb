# frozen_string_literal: true

RSpec.shared_examples 'base request examples' do
  let(:test_required_fields) { [] } unless method_defined? :test_required_fields
  let(:test_required_field_values) { [] } unless method_defined? :test_required_field_values

  it 'can build structure' do
    expect(request.build_document).to_not be_empty
  end

  it 'when required fields with nil values' do
    test_required_fields.each do |field|
      request_copy = request.dup

      request_copy.__send__ "#{field}=".to_sym, nil

      expect { request_copy.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  it 'when required field values' do
    test_required_field_values.each do |field|
      request_copy = request.dup

      request_copy.__send__ "#{field}=".to_sym, 'invalid'

      expect { request_copy.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
