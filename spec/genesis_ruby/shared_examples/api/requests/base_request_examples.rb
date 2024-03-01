RSpec.shared_examples 'base request examples' do
  let(:test_required_fields) { [] } unless method_defined? :test_required_fields

  it 'can build structure' do
    expect(request.build_document).to_not be_empty
  end

  it 'when required fields with nil values' do
    test_required_fields.each do |field|
      request.__send__ "#{field}=".to_sym, nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
