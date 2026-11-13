# frozen_string_literal: true

RSpec.shared_examples 'purpose of payment attributes examples' do
  describe 'when purpose of payment attributes' do
    it 'with Visa code' do
      request.purpose_of_payment = 'ISBONU'

      expect(request.build_document).to include '<purpose_of_payment>ISBONU</purpose_of_payment>'
    end

    it 'with Visa value' do
      request.purpose_of_payment = 'bonus_payment'

      expect(request.build_document).to include '<purpose_of_payment>bonus_payment</purpose_of_payment>'
    end

    it 'with invalid value' do
      expect { request.purpose_of_payment = 'unknown_purpose' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'without purpose_of_payment' do
      expect(request.build_document).to_not include 'purpose_of_payment'
    end

    it 'with nil value' do
      request.purpose_of_payment = nil

      expect(request.build_document).to_not include 'purpose_of_payment'
    end

    it 'with empty value' do
      request.purpose_of_payment = ''

      expect(request.build_document).to_not include 'purpose_of_payment'
    end
  end
end

RSpec.shared_examples 'purpose of payment default allow-list examples' do
  describe 'when purpose of payment default allow-list' do
    it 'with Mastercard money transfer value' do
      expect { request.purpose_of_payment = 'crowd_lending' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
