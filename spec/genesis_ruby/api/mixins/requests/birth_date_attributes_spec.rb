# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/birth_date_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::BirthDateAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::BirthDateAttributesStub.new }
  let(:dummy_date) { '2024-01-01' }

  describe 'when birth date accessors' do
    it 'with setter' do
      expect { attributes.birth_date = dummy_date }.to_not raise_error
    end

    it 'with getter' do
      attributes.birth_date = dummy_date

      expect(attributes.birth_date).to eq '01-01-2024'
    end
  end
end
