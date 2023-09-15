RSpec.shared_examples 'base request examples' do
  it 'can build structure' do
    expect(request.build_document).to_not be_empty
  end
end
