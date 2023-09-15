RSpec.shared_examples 'option examples' do
  describe 'with proper initialization' do
    it 'set hash' do
      expect { described_class[] }.to_not raise_error
    end

    it 'with default values' do
      hash = described_class[initialized_key: 1]

      expect(hash.initialized_key).to eq(1)
    end
  end

  describe 'with defined dynamic methods' do
    it 'has dynamic assignment' do
      options.dynamic = 'dynamic_method'

      expect(options.dynamic).to eq('dynamic_method')
    end

    it 'has method call' do
      options.dynamic = 'dynamic_method'

      expect { options.method('dynamic') }.to_not raise_exception
    end
  end

  describe 'with undefined dynamic methods' do
    it 'not raise error when called with method_missing' do
      expect { options.not_defined }.to_not raise_error
    end

    it 'has nil value' do
      expect(options.not_defined).to eq(nil)
    end

    it 'raise error when called with method' do
      expect { options.method('not_defined') }.to raise_error NameError
    end
  end
end
