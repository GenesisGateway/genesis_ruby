require 'spec/genesis_ruby/stubs/api/requests/financial/risk_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::RiskAttributes do
  let(:risk_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::RiskAttributesStub.new }

  it 'when request structure' do
    expect(risk_attributes.risk_parameters_structure).to be_kind_of Hash
  end

  describe 'when risk params accessors' do
    it 'with ssn' do
      risk_attributes.risk_ssn = ssn = Faker::Number.positive

      expect(risk_attributes.risk_ssn).to eq ssn
    end

    it 'with mac address' do
      risk_attributes.risk_mac_address = mac = Faker::Internet.mac_address

      expect(risk_attributes.risk_mac_address).to eq mac
    end

    it 'with session id' do
      risk_attributes.risk_session_id = session_id = Faker::Internet.uuid

      expect(risk_attributes.risk_session_id).to eq session_id
    end

    it 'with user id' do
      risk_attributes.risk_user_id = user_id = Faker::Number.positive

      expect(risk_attributes.risk_user_id).to eq user_id
    end

    it 'with user level' do
      risk_attributes.risk_user_level = level = Faker::Number.positive

      expect(risk_attributes.risk_user_level).to eq level
    end

    it 'with email' do
      risk_attributes.risk_email = email = Faker::Internet.email

      expect(risk_attributes.risk_email).to eq email
    end

    it 'with phone' do
      risk_attributes.risk_phone = phone = Faker::PhoneNumber.cell_phone

      expect(risk_attributes.risk_phone).to eq phone
    end

    it 'with remote ip' do
      risk_attributes.risk_remote_ip = remote_ip = Faker::Internet.ip_v4_address

      expect(risk_attributes.risk_remote_ip).to eq remote_ip
    end

    it 'with serial number' do
      risk_attributes.risk_serial_number = number = Faker::Number.positive

      expect(risk_attributes.risk_serial_number).to eq number
    end

    it 'with pan tail' do
      risk_attributes.risk_pan_tail = tail = Faker::Number.rand_in_range 0, 9999

      expect(risk_attributes.risk_pan_tail).to eq tail
    end

    it 'with bin' do
      risk_attributes.risk_bin = bin = Faker::Number.rand_in_range 0, 999_999

      expect(risk_attributes.risk_bin).to eq bin
    end

    it 'with first name' do
      risk_attributes.risk_first_name = name = Faker::Name.first_name

      expect(risk_attributes.risk_first_name).to eq name
    end

    it 'with last name' do
      risk_attributes.risk_last_name = name = Faker::Name.last_name

      expect(risk_attributes.risk_last_name).to eq name
    end

    it 'with country' do
      risk_attributes.risk_country = country = Faker::Address.country

      expect(risk_attributes.risk_country).to eq country
    end

    it 'with pan' do
      risk_attributes.risk_pan = pan = Faker::Internet.uuid

      expect(risk_attributes.risk_pan).to eq pan
    end

    it 'with forwarded ip' do
      risk_attributes.risk_forwarded_ip = forwarded_ip = Faker::Internet.ip_v4_address

      expect(risk_attributes.risk_forwarded_ip).to eq forwarded_ip
    end

    it 'with username' do
      risk_attributes.risk_username = user = Faker::Internet.username

      expect(risk_attributes.risk_username).to eq user
    end

    it 'with password' do
      risk_attributes.risk_password = pass = Faker::Internet.password

      expect(risk_attributes.risk_password).to eq pass
    end

    it 'with bin name' do
      risk_attributes.risk_bin_name = name = Faker::Internet.user

      expect(risk_attributes.risk_bin_name).to eq name
    end

    it 'with bin phone' do
      risk_attributes.risk_bin_phone = phone = Faker::PhoneNumber.cell_phone

      expect(risk_attributes.risk_bin_phone).to eq phone
    end
  end
end
