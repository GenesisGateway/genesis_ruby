# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/business/cruise_lines_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::CruiseLinesAttributes do
  let(:cruise_lines) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::CruiseLinesAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(cruise_lines.cruise_lines_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        cruise_lines.cruise_lines_attributes_structure.keys
      ).to eq [
        :cruise_start_date,
        :cruise_end_date
      ]
    end
  end

  describe 'when business_cruise_start_date' do
    it 'with valid value' do
      cruise_lines.business_cruise_start_date = fake_date.to_s

      expect(
        cruise_lines.business_cruise_start_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        cruise_lines.business_cruise_start_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_cruise_end_date' do
    it 'with valid value' do
      cruise_lines.business_cruise_end_date = fake_date.to_s

      expect(
        cruise_lines.business_cruise_end_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        cruise_lines.business_cruise_end_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
