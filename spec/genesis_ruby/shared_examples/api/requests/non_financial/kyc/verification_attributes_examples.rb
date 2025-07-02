# frozen_string_literal: true

RSpec.shared_examples 'verification attributes examples' do
  describe 'when Verification attributes examples' do
    describe 'when valid request' do
      it 'with different expiry_date format' do
        request.expiry_date = '31-12-2025'
        expect(request.build_document).to include '"expiry_date": "2025-12-31"'
      end
    end

    describe 'when invalid request' do
      it 'with invalid email format' do
        expect { request.email = 'invalid_email' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid country code' do
        expect { request.country = 'XX' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid backside_proof_required' do
        expect { request.backside_proof_required = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid document_supported_types' do
        expect { request.document_supported_types = ['invalid_type'] }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end

end
