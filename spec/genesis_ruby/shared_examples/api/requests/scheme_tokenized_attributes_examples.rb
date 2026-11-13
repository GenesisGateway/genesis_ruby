# frozen_string_literal: true

RSpec.shared_examples 'scheme tokenized attributes examples' do
  describe 'when scheme_tokenized' do
    it 'without value' do
      expect(request.build_document).to_not include 'scheme_tokenized'
    end

    it 'with true value' do
      request.scheme_tokenized = true

      expect(request.build_document.scan('<scheme_tokenized>true</scheme_tokenized>').size).to eq 1
    end

    it 'with false value' do
      request.scheme_tokenized = false

      expect(request.build_document.scan('<scheme_tokenized>false</scheme_tokenized>').size).to eq 1
    end

    it 'keeps the other elements unchanged' do
      baseline                 = request.build_document
      request.scheme_tokenized = true

      expect(request.build_document.sub(%r{\s*<scheme_tokenized>true</scheme_tokenized>}, '')).to eq baseline
    end

    [nil, ''].each do |value|
      it "with empty value #{value.inspect}" do
        request.scheme_tokenized = true
        request.scheme_tokenized = value

        expect(request.scheme_tokenized).to be_nil
      end
    end

    ['true', 'false', 'yes', 1, 0].each do |value|
      it "with invalid value #{value.inspect}" do
        expect { request.scheme_tokenized = value }
          .to raise_error GenesisRuby::InvalidArgumentError, /Accepts only boolean values/
      end
    end

    it 'keeps the previous value after an invalid assignment' do # rubocop:disable RSpec/MultipleExpectations
      request.scheme_tokenized = true

      expect { request.scheme_tokenized = 'yes' }.to raise_error GenesisRuby::InvalidArgumentError
      expect(request.scheme_tokenized).to be true
    end
  end
end
