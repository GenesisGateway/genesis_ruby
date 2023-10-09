RSpec.shared_examples 'reference attributes examples' do
  describe 'when reference attributes' do
    it 'without reference_id' do
      skip 'Reference transaction must contain reference_id' if required_reference_id?

      expect(request.build_document).to_not include 'reference_id'
    end

    it 'with reference_id' do
      request.reference_id = reference_id = Faker::Internet.uuid

      expect(request.build_document).to include "<reference_id>#{reference_id}</reference_id>"
    end
  end

  private

  # Validate the given request if requires reference_id
  def required_reference_id?
    request.is_a?(GenesisRuby::Api::Requests::Base::Reference) ||
      request.is_a?(GenesisRuby::Api::Requests::Financial::Void)
  end
end
