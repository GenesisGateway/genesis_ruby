# frozen_string_literal: true

RSpec.shared_examples 'credential on file attributes examples' do
  describe 'when credential_on_files' do
    it 'without attributes' do
      expect(request.build_document).to_not include 'credential_on_file'
    end

    it 'with valid value' do
      request.credential_on_file = credential = GenesisRuby::Api::Constants::Transactions::Parameters::
          CredentialOnFiles.all.sample

      expect(request.build_document).to include "<credential_on_file>#{credential}</credential_on_file>"
    end

    it 'with invalid value' do
      request.credential_on_file = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
