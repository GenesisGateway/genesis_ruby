# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/date_time_from_to_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::DateTimeFromToAttributes do
  let(:date) { '2024-01-01' }
  let(:date_time) { '2024-01-01 12:59:59' }
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::DateTimeFromToAttributesStub.new }

  %i[start_date_from start_date_to end_date_from end_date_to].each do |attribute|
    describe "when #{attribute}" do
      let(:setter) { :"#{attribute}=" }

      it 'with date reads back as date' do
        attributes.public_send setter, date

        expect(attributes.public_send(attribute)).to eq date
      end

      it 'with datetime reads back unchanged' do
        attributes.public_send setter, date_time

        expect(attributes.public_send(attribute)).to eq date_time
      end

      it 'with date reassigned after datetime drops the time' do
        attributes.public_send setter, date_time
        attributes.public_send setter, date

        expect(attributes.public_send(attribute)).to eq date
      end

      it 'with empty string clears the value' do
        attributes.public_send setter, date
        attributes.public_send setter, ''

        expect(attributes.public_send(attribute)).to be_nil
      end

      it 'with nil clears the value' do
        attributes.public_send setter, date
        attributes.public_send setter, nil

        expect(attributes.public_send(attribute)).to be_nil
      end

      it 'with malformed value raises error' do
        expect { attributes.public_send setter, 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end
end
