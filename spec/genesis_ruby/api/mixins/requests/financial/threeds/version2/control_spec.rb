require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/control_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Control do
  let(:control) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::ControlStub.new
  end

  describe 'when threeds_v2_control_device_type' do
    it 'with valid type' do
      control.threeds_v2_control_device_type = type = 'browser'

      expect(control.threeds_v2_control_device_type).to eq(type)
    end

    it 'with empty type' do
      control.threeds_v2_control_device_type = ''

      expect(control.threeds_v2_control_device_type).to eq(nil)
    end

    it 'with invalid type' do
      expect do
        control.threeds_v2_control_device_type = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_control_challenge_indicator' do
    it 'with valid indicator' do
      control.threeds_v2_control_challenge_indicator = indicator = 'no_preference'

      expect(control.threeds_v2_control_challenge_indicator).to eq(indicator)
    end

    it 'with empty indicator' do
      control.threeds_v2_control_challenge_indicator = ''

      expect(control.threeds_v2_control_challenge_indicator).to eq(nil)
    end

    it 'with invalid indicator' do
      expect do
        control.threeds_v2_control_challenge_indicator = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_control_challenge_window_size' do
    it 'with valid size' do
      control.threeds_v2_control_challenge_window_size = indicator = '250x400'

      expect(control.threeds_v2_control_challenge_window_size).to eq(indicator)
    end

    it 'with empty size' do
      control.threeds_v2_control_challenge_window_size = ''

      expect(control.threeds_v2_control_challenge_window_size).to eq(nil)
    end

    it 'with invalid size' do
      expect do
        control.threeds_v2_control_challenge_window_size = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(control.control_attributes).to_not be_empty
  end

end
