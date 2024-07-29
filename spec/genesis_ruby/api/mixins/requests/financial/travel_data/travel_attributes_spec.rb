RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::TravelData::TravelAttributes do
  it 'when airline itinerary attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::TravelData::AirlineItineraryAttributes)
    ).to be true
  end

  it 'when car rental attributes' do
    expect(described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::TravelData::CarRentalAttributes))
      .to be true
  end

  it 'with hotel rental attributes' do
    expect(described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::TravelData::HotelRentalAttributes))
      .to be true
  end

  it 'with reference ticket attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::TravelData::ReferenceTicketAttributes)
    ).to be true
  end
end
