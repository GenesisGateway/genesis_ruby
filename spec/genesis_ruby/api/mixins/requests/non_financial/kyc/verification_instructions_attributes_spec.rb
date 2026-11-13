# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/verification_instructions_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationInstructionsAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::VerificationInstructionsAttributesStub.new }

  describe 'when verification instructions structure' do
    it 'with proper type' do
      expect(attributes.verification_instructions_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do
      expect(attributes.verification_instructions_attributes_structure.keys).to eq(
        %i[allow_paper_based allow_photocopy allow_laminated allow_screenshot allow_cropped allow_scanned]
      )
    end
  end

  describe 'when allow_paper_based' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_paper_based = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_paper_based = true

      expect(attributes.verification_instructions_allow_paper_based).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_paper_based = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_photocopy' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_photocopy = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_photocopy = true

      expect(attributes.verification_instructions_allow_photocopy).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_photocopy = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_laminated' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_laminated = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_laminated = true

      expect(attributes.verification_instructions_allow_laminated).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_laminated = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_screenshot' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_screenshot = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_screenshot = true

      expect(attributes.verification_instructions_allow_screenshot).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_screenshot = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_cropped' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_cropped = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_cropped = true

      expect(attributes.verification_instructions_allow_cropped).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_cropped = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_scanned' do
    it 'with setter' do
      expect { attributes.verification_instructions_allow_scanned = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.verification_instructions_allow_scanned = true

      expect(attributes.verification_instructions_allow_scanned).to eq true
    end

    it 'with invalid value' do
      expect { attributes.verification_instructions_allow_scanned = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

end
