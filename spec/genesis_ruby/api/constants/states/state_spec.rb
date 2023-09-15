RSpec.describe GenesisRuby::Api::Constants::States::State do
  describe 'when valid state loaded' do
    let(:state) { described_class.new('new') }

    it 'validates new? state correctly' do
      expect(state.new?).to eq(true)
    end

    it 'validates approved? state correctly' do
      expect(state.approved?).to eq(false)
    end

    it 'with invalid state' do
      expect { state.invalid_state? }.to raise_error NoMethodError
    end

    it 'with invalid method' do
      expect { state.missing_method }.to raise_error NoMethodError
    end
  end

  describe 'when invalid state loaded' do
    let(:state) { described_class.new('invalid') }

    it 'validates new? state correctly' do
      expect(state.new?).to eq(false)
    end

    it 'validate approved? state correctly' do
      expect(state.approved?).to eq(false)
    end
  end

end
