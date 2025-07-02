# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/face_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::FaceAttributes do
  let(:face_attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::FaceAttributesStub.new }

  it 'when face attributes structure' do
    expect(face_attributes.face_attributes_structure).to be_kind_of Hash
  end

  describe 'when allow_offline' do
    it 'with setter' do
      expect { face_attributes.face_allow_offline = true }.to_not raise_error
    end

    it 'with getter' do
      face_attributes.face_allow_offline = true

      expect(face_attributes.face_allow_offline).to eq true
    end

    it 'with invalid value' do
      expect { face_attributes.face_allow_offline = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_online' do
    it 'with setter' do
      expect { face_attributes.face_allow_online = true }.to_not raise_error
    end

    it 'with getter' do
      face_attributes.face_allow_online = true

      expect(face_attributes.face_allow_online).to eq true
    end

    it 'with invalid value' do
      expect { face_attributes.face_allow_online = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when check_duplicate_request' do
    it 'with setter' do
      expect { face_attributes.face_check_duplicate_request = true }.to_not raise_error
    end

    it 'with getter' do
      face_attributes.face_check_duplicate_request = true

      expect(face_attributes.face_check_duplicate_request).to eq true
    end

    it 'with invalid value' do
      expect { face_attributes.face_check_duplicate_request = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

end
