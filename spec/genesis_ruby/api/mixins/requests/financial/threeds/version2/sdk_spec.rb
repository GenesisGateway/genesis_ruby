require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/sdk_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Sdk  do
  let(:sdk) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::SdkStub.new
  end

  describe 'when threeds_v2_sdk_interface' do
    it 'with setter' do
      expect { sdk.threeds_v2_sdk_interface = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      sdk.threeds_v2_sdk_interface = interface = 'native'

      expect(sdk.threeds_v2_sdk_interface).to eq interface
    end

    it 'with empty interface' do
      sdk.threeds_v2_sdk_interface = ''

      expect(sdk.threeds_v2_sdk_interface).to eq ''
    end
  end

  describe 'when threeds_v2_sdk_ui_types' do
    it 'with valid types' do
      sdk.threeds_v2_sdk_ui_types = 'text'
      sdk.threeds_v2_sdk_ui_types = 'single_select'

      expect(sdk.threeds_v2_sdk_ui_types).to eq %w(text single_select)
    end

    it 'with empty type' do
      expect { sdk.threeds_v2_sdk_ui_types = '' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid interface' do
      expect { sdk.threeds_v2_sdk_ui_types = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_sdk_application_id' do
    it 'with valid identifier' do
      sdk.threeds_v2_sdk_application_id = identifier = Faker::Internet.uuid

      expect(sdk.threeds_v2_sdk_application_id).to eq identifier
    end

    it 'with empty identifier' do
      sdk.threeds_v2_sdk_application_id = ''

      expect(sdk.threeds_v2_sdk_application_id).to eq nil
    end

    it 'with invalid identifier' do
      expect do
        sdk.threeds_v2_sdk_application_id = Faker::String.random length: 37
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_sdk_encrypted_data' do
    it 'with valid data' do
      sdk.threeds_v2_sdk_encrypted_data = data = 'encrypted-data'

      expect(sdk.threeds_v2_sdk_encrypted_data).to eq data
    end

    it 'with empty data' do
      sdk.threeds_v2_sdk_encrypted_data = ''

      expect(sdk.threeds_v2_sdk_encrypted_data).to eq nil
    end

    it 'with invalid data' do
      expect do
        sdk.threeds_v2_sdk_encrypted_data = Faker::String.random length: 64_001
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_sdk_ephemeral_public_key_pair' do
    it 'with valid key' do
      sdk.threeds_v2_sdk_ephemeral_public_key_pair = key = 'public-key-pair'

      expect(sdk.threeds_v2_sdk_ephemeral_public_key_pair).to eq key
    end

    it 'with empty data' do
      sdk.threeds_v2_sdk_ephemeral_public_key_pair = ''

      expect(sdk.threeds_v2_sdk_ephemeral_public_key_pair).to eq nil
    end

    it 'with invalid data' do
      expect do
        sdk.threeds_v2_sdk_ephemeral_public_key_pair = Faker::String.random length: 257
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_sdk_max_timeout' do
    it 'with integer value' do
      sdk.threeds_v2_sdk_max_timeout = timeout = 5

      expect(sdk.threeds_v2_sdk_max_timeout).to eq timeout
    end

    it 'with string value' do
      sdk.threeds_v2_sdk_max_timeout = timeout = '5'

      expect(sdk.threeds_v2_sdk_max_timeout).to eq timeout.to_i
    end

    it 'with empty value' do
      sdk.threeds_v2_sdk_max_timeout = ''

      expect(sdk.threeds_v2_sdk_max_timeout).to eq nil
    end

    it 'with negative value' do
      expect do
        sdk.threeds_v2_sdk_max_timeout = -5
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_sdk_reference_number' do
    it 'with valid identifier' do
      sdk.threeds_v2_sdk_reference_number = number = 'reference-number'

      expect(sdk.threeds_v2_sdk_reference_number).to eq number
    end

    it 'with empty identifier' do
      sdk.threeds_v2_sdk_reference_number = ''

      expect(sdk.threeds_v2_sdk_reference_number).to eq nil
    end

    it 'with invalid identifier' do
      expect do
        sdk.threeds_v2_sdk_reference_number = Faker::String.random length: 33
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(sdk.sdk_attributes).to_not be_empty
  end

  it 'with sdk field validations' do
    expect(sdk.threeds_sdk_field_validations).to_not be_empty
  end
end
