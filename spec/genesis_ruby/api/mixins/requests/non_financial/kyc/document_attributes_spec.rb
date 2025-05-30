require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/document_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::DocumentAttributes do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:document_attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::DocumentAttributesStub.new
  end

  let(:proof)         { Faker::Lorem.word }
  let(:date_of_birth) do
    Faker::Date.forward.strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601)
  end
  let(:first_name)    { Faker::Name.first_name }
  let(:middle_name)   { Faker::Name.middle_name }
  let(:last_name)     { Faker::Name.last_name }
  let(:full_address)  { Faker::Address.full_address }

  describe 'document attributes structure' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      document_attributes.proof         = proof
      document_attributes.date_of_birth = date_of_birth
      document_attributes.first_name    = first_name
      document_attributes.middle_name   = middle_name
      document_attributes.last_name     = last_name
      document_attributes.full_address  = full_address

      expected_hash = {
        proof:         proof,
        date_of_birth: date_of_birth,
        first_name:    first_name,
        middle_name:   middle_name,
        last_name:     last_name,
        full_address:  full_address
      }

      structure = document_attributes.public_send(:document_attributes_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
