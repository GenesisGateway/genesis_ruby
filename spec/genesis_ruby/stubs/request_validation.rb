# frozen_string_literal: true

require 'genesis_ruby/api/request'

module GenesisSpec
  module Stubs
    # Request Skeleton
    class RequestValidation < GenesisRuby::Api::Request

      attr_accessor :field1, :field2, :field3, :field4, :field5, :field6, :field7, :field8

      protected

      def init_configuration
        init_xml_configuration
        init_api_gateway_configuration
      end

      def init_field_validations
        self.required_fields = %i[field1]
        self.field_values = { field3: %w(value1 value2 value3), field4: 'value4' }
        self.field_value_dependencies = {
          field5: { value1: %i[field1 field2] },
          field6: { value1: { field5: %w(value1 value2) } },
          field7: { true => %i[field2] },
          field8: %i[field2 field3]
        }

        super
      end

      def populate_structure
        self.tree_structure = {
          root: {
            field1: field1,
            field2: field2,
            field3: field3,
            field4: field4
          }
        }
      end

    end
  end
end
