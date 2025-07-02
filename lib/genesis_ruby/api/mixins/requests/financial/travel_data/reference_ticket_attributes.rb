# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/travel_data/ancillary_charges_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module TravelData
            # Ancillary Charges
            module ReferenceTicketAttributes

              attr_reader :travel_ac_ticket_reference_id, :travel_ac_type, :travel_ac_ticket_document_number,
                          :travel_ac_issued_with_ticket_number, :travel_ac_sub_type

              # Ancillary Charges ticker reference id
              def travel_ac_ticket_reference_id=(value)
                limited_string attribute: __method__, value: value, max: 32
              end

              # Ancillary Charges Type
              def travel_ac_type=(value)
                allowed_options attribute:   __method__,
                                value:       value.to_s.upcase,
                                allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::TravelData::
                                    AncillaryChargesTypes.all,
                                allow_empty: true
              end

              # Ancillary Charges Ticket document number
              def travel_ac_ticket_document_number=(value)
                limited_string attribute: __method__, value: value, max: 15
              end

              # Ancillary Charges issued with ticket number
              def travel_ac_issued_with_ticket_number=(value)
                limited_string attribute: __method__, value: value, max: 15
              end

              # Ancillary Charges Sub Type
              def travel_ac_sub_type=(value)
                allowed_options attribute:   __method__,
                                value:       value.to_s.upcase,
                                allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::TravelData::
                                    AncillaryChargesTypes.all,
                                allow_empty: true
              end

              protected

              # Reference Ticket attributes structure
              def reference_ticket_attributes_structure
                {
                  ticket_reference_id:       travel_ac_ticket_reference_id,
                  ticket_document_number:    travel_ac_ticket_document_number,
                  issued_with_ticket_number: travel_ac_issued_with_ticket_number
                }
              end

              # Ancillary Charges attributes structure
              def charges_attributes_structure
                {
                  charge: {
                    type:     travel_ac_type,
                    sub_type: travel_ac_sub_type
                  }
                }
              end

            end
          end
        end
      end
    end
  end
end
