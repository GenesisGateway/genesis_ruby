# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/refund/travel_ticket_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Refund::TravelTicketAttributes do
  let(:ticket_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Refund::TravelTicketAttributesStub.new }
  let(:credit_reasons) { GenesisRuby::Api::Constants::Transactions::Parameters::Refund::CreditReasonIndicators }
  let(:ticket_changes) { GenesisRuby::Api::Constants::Transactions::Parameters::Refund::TicketChangeIndicators }
  let(:attribute_names) { %w(credit_reason_indicator_1 credit_reason_indicator_2 ticket_change_indicator) }

  def ticket_hash(values)
    attribute_names.map(&:to_sym).zip(values).to_h
  end

  refund_constants = GenesisRuby::Api::Constants::Transactions::Parameters::Refund

  {
    'credit_reason_indicator_1' => refund_constants::CreditReasonIndicators,
    'credit_reason_indicator_2' => refund_constants::CreditReasonIndicators,
    'ticket_change_indicator'   => refund_constants::TicketChangeIndicators
  }.each do |name, constants|
    describe "when #{name}" do
      it 'with setter' do
        constants.all.each do |value|
          expect { ticket_attributes.__send__("#{name}=", value) }.to_not raise_error
        end
      end

      it 'with getter' do
        constants.all.each do |value|
          ticket_attributes.__send__("#{name}=", value)

          expect(ticket_attributes.__send__(name)).to eq value
        end
      end

      it 'with invalid value setter' do
        %w(Z a invalid).each do |value|
          expect { ticket_attributes.__send__("#{name}=", value) }.to_not raise_error
        end
      end

      it 'with invalid value getter' do
        %w(Z a invalid).each do |value|
          ticket_attributes.__send__("#{name}=", value)

          expect(ticket_attributes.__send__(name)).to eq value
        end
      end

      it 'with nil setter' do
        expect { ticket_attributes.__send__("#{name}=", nil) }.to_not raise_error
      end

      it 'with nil value' do
        ticket_attributes.__send__("#{name}=", constants.all.first)
        ticket_attributes.__send__("#{name}=", nil)

        expect(ticket_attributes.__send__(name)).to be_nil
      end

      it 'without assigned value' do
        expect(ticket_attributes.__send__(name)).to be_nil
      end
    end
  end

  describe 'when refund_travel_ticket_attributes_structure' do
    let(:structure) { ticket_attributes.refund_travel_ticket_attributes_structure }

    it 'does not raise on the stub alone' do
      expect { ticket_attributes.refund_travel_ticket_attributes_structure }.to_not raise_error
    end

    it 'returns nil values without assigned attributes' do
      expect(structure).to eq(travel: { ticket: ticket_hash([nil, nil, nil]) })
    end

    it 'returns only the travel node' do
      expect(structure.keys).to eq %i[travel]
    end

    it 'returns only the ticket node under travel' do
      expect(structure[:travel].keys).to eq %i[ticket]
    end

    it 'returns the ticket keys in order' do
      expect(structure[:travel][:ticket].keys).to eq attribute_names.map(&:to_sym)
    end

    it 'returns the assigned values' do
      values = [credit_reasons::INDICATOR_A, credit_reasons::INDICATOR_O, ticket_changes::INDICATOR_N]
      attribute_names.zip(values).each { |name, value| ticket_attributes.__send__("#{name}=", value) }

      expect(structure).to eq(travel: { ticket: ticket_hash(values) })
    end
  end

  describe 'when refund_travel_ticket_attributes_field_validations' do
    let(:validations) { ticket_attributes.refund_travel_ticket_attributes_field_validations }

    it 'does not raise on the stub alone' do
      expect { ticket_attributes.refund_travel_ticket_attributes_field_validations }.to_not raise_error
    end

    it 'returns the indicator constants' do
      expect(validations).to eq ticket_hash([credit_reasons.all, credit_reasons.all, ticket_changes.all])
    end

    it 'returns all allowed credit reason indicator values' do
      attribute_names.first(2).each do |name|
        expect(validations[name.to_sym]).to match_array %w(A B P O)
      end
    end

    it 'returns all allowed ticket change indicator values' do
      expect(validations[:ticket_change_indicator]).to match_array %w(C N)
    end
  end

  describe 'when method names' do
    let(:mixin_methods) do
      described_class.instance_methods(false) + described_class.protected_instance_methods(false) +
        described_class.private_instance_methods(false)
    end

    def all_methods(mod)
      mod.public_instance_methods + mod.protected_instance_methods + mod.private_instance_methods
    end

    def helper_names
      %i[refund_travel_ticket_attributes_structure refund_travel_ticket_attributes_field_validations]
    end

    def travel_data_helper_names
      %i[
        travel_data_attributes_structure reference_ticket_attributes_structure charges_attributes_structure
        airline_attributes_structure
      ]
    end

    it 'declares the helpers as protected methods' do
      expect(described_class.protected_instance_methods(false)).to match_array helper_names
    end

    it 'uses helper names that differ from the travel data helpers' do
      expect(helper_names & travel_data_helper_names).to be_empty
    end

    it 'does not clash with the travel data attributes' do
      travel_data = GenesisRuby::Api::Mixins::Requests::Financial::TravelData::TravelAttributes

      expect(mixin_methods & all_methods(travel_data)).to be_empty
    end

    it 'does not clash with the base reference request' do
      expect(mixin_methods & all_methods(GenesisRuby::Api::Requests::Base::Reference)).to be_empty
    end
  end
end
