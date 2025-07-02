# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/credential_on_file_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::CredentialOnFileAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::CredentialOnFileAttributesStub.new }

  describe 'when accessors' do
    let(:credential) { 'initial_customer_initiated' }

    it 'with getter' do
      attributes.credential_on_file = credential

      expect(attributes.credential_on_file).to eq 'initial_customer_initiated'
    end

    it 'with setter' do
      expect { attributes.credential_on_file = 'value' }.to_not raise_error
    end
  end

  it 'when credential_on_file with field validations' do
    expect(attributes.credential_on_file_field_validations).to be_kind_of Hash
  end
end
