require 'spec/genesis_ruby/stubs/api/requests/financial/business/event_management_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::EventManagementAttributes do
  let(:event_management) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::EventManagementAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(event_management.event_management_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        event_management.event_management_attributes_structure.keys
      ).to eq [
        :event_start_date,
        :event_end_date,
        :event_organizer_id,
        :event_id
      ]
    end
  end

  describe 'when business_event_start_date' do
    it 'with valid value' do
      event_management.business_event_start_date = fake_date.to_s

      expect(
        event_management.business_event_start_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        event_management.business_event_start_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_event_end_date' do
    it 'with valid value' do
      event_management.business_event_end_date = fake_date.to_s

      expect(
        event_management.business_event_end_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        event_management.business_event_end_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_event_organizer_id' do
    it 'with accessors' do
      event_management.business_event_organizer_id = identifier = Faker::Number.positive

      expect(event_management.business_event_organizer_id).to eq identifier
    end
  end

  describe 'when business_event_id' do
    it 'with accessors' do
      event_management.business_event_id = identifier = Faker::Number.positive

      expect(event_management.business_event_id).to eq identifier
    end
  end
end
