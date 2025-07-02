# frozen_string_literal: true

RSpec.shared_examples 'reference attributes examples' do
  describe 'when reference attributes' do
    it 'without reference_id' do
      skip 'Reference transaction must contain reference_id' if required_reference_id?

      expect(request.build_document).to_not include 'reference_id'
    end

    it 'with reference_id' do # rubocop:disable RSpec/ExampleLength
      request.reference_id = reference_id = Faker::Internet.uuid

      expectation = "<reference_id>#{reference_id}</reference_id>"

      if request.instance_variable_get('@builder_interface') == 'json'
        expectation = "\"reference_id\": \"#{reference_id}\""
      end

      expect(request.build_document).to include expectation
    end
  end

  private

  # Validate the given request if requires reference_id
  def required_reference_id?
    request.is_a?(GenesisRuby::Api::Requests::Base::Reference) ||
      request.is_a?(GenesisRuby::Api::Requests::Financial::Void) ||
      request.is_a?(GenesisRuby::Api::Requests::Financial::Crypto::BitPay::Refund) ||
      request.is_a?(GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::Register) ||
      request.is_a?(GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::Status)
  end
end
