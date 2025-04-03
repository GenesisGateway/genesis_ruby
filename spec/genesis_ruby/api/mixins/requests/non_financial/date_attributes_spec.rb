require 'spec/genesis_ruby/stubs/api/requests/non_financial/date_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::DateAttributes do
  let(:date) { '2023-01-01' }
  let(:time) { '12:59:59' }
  let(:timestamp_object) do
    GenesisRuby::Utils::Common.parse_date(
      "#{date} #{time}",
      GenesisRuby::Api::Constants::DateTimeFormats.all
    )
  end
  let(:date_attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::DateAttributesStub.new }

  describe 'when start_date' do
    it 'with time' do
      date_attributes.start_date =
        timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S

      expect(date_attributes.start_date).to eq "#{date} #{time}"
    end

    it 'without time' do
      date_attributes.start_date =
        timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601

      expect(date_attributes.start_date).to eq date
    end
  end

  describe 'when end_date' do
    it 'with time' do
      date_attributes.end_date =
        timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S

      expect(date_attributes.end_date).to eq "#{date} #{time}"
    end

    it 'without time' do
      date_attributes.end_date =
        timestamp_object.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601

      expect(date_attributes.end_date).to eq date
    end
  end
end
