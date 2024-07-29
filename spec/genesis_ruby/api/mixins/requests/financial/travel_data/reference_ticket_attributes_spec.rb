require 'spec/genesis_ruby/stubs/api/requests/financial/travel_data/reference_ticket_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::TravelData::ReferenceTicketAttributes do
  let(:reference) { GenesisSpec::Stubs::Api::Requests::Financial::TravelData::ReferenceTicketAttributesStub.new }

  describe 'when ticket reference id' do
    let(:identifier) { Faker::Internet.uuid[1..32] }

    it 'with valid data' do
      expect { reference.travel_ac_ticket_reference_id = identifier }.to_not raise_error
    end

    it 'with invalid data' do
      expect { reference.travel_ac_ticket_reference_id = "#{identifier}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      reference.travel_ac_ticket_reference_id = identifier

      expect(reference.travel_ac_ticket_reference_id).to eq identifier
    end
  end

  describe 'when ac type' do
    let(:type) { GenesisRuby::Api::Constants::Transactions::Parameters::TravelData::AncillaryChargesTypes.all.sample }

    it 'with valid data' do
      expect { reference.travel_ac_type = type }.to_not raise_error
    end

    it 'with invalid data' do
      expect { reference.travel_ac_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with lowercase value' do
      expect { reference.travel_ac_type = type.downcase }.to_not raise_error
    end

    it 'with getter' do
      reference.travel_ac_type = type

      expect(reference.travel_ac_type).to eq type
    end
  end

  describe 'when ticket document number' do
    let(:number) { Faker::Internet.uuid[1..15] }

    it 'with valid data' do
      expect { reference.travel_ac_ticket_document_number = number }.to_not raise_error
    end

    it 'with invalid data' do
      expect { reference.travel_ac_ticket_document_number = "#{number}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      reference.travel_ac_ticket_document_number = number

      expect(reference.travel_ac_ticket_document_number).to eq number
    end
  end

  describe 'when issued with ticket number' do
    let(:number) { Faker::Internet.uuid[1..15] }

    it 'with valid data' do
      expect { reference.travel_ac_issued_with_ticket_number = number }.to_not raise_error
    end

    it 'with invalid data' do
      expect { reference.travel_ac_issued_with_ticket_number = "#{number}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      reference.travel_ac_issued_with_ticket_number = number

      expect(reference.travel_ac_issued_with_ticket_number).to eq number
    end
  end

  describe 'when sub type' do
    let(:type) { GenesisRuby::Api::Constants::Transactions::Parameters::TravelData::AncillaryChargesTypes.all.sample }

    it 'with valid data' do
      expect { reference.travel_ac_sub_type = type }.to_not raise_error
    end

    it 'with invalid data' do
      expect { reference.travel_ac_sub_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with lowercase value' do
      expect { reference.travel_ac_sub_type = type.downcase }.to_not raise_error
    end

    it 'with getter' do
      reference.travel_ac_sub_type = type

      expect(reference.travel_ac_sub_type).to eq type
    end
  end
end
