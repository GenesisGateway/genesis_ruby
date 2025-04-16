require 'spec/genesis_ruby/stubs/api/requests/non_financial/mode_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::ModeAttributes do
  let(:list) { 'list' }
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::ModeAttributesStub.new }

  describe 'when mode accessors' do
    it 'with setter' do
      expect { attributes.mode = list }.to_not raise_error
    end

    it 'with getter' do
      attributes.mode = list

      expect(attributes.mode).to eq list
    end
  end

  describe 'when mode' do
    it 'with invalid value' do
      expect { attributes.mode = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with nil value' do
      expect { attributes.mode = nil }.to_not raise_error
    end

    it 'with empty value' do
      expect { attributes.mode = '' }.to_not raise_error
    end
  end

end
