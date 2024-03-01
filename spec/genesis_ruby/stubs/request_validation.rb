require 'genesis_ruby/api/request'

module GenesisSpec
  module Stubs
    # Request Skeleton
    class RequestValidation < GenesisRuby::Api::Request

      attr_accessor :field1, :field2

      protected

      def init_configuration
        init_xml_configuration
        init_api_gateway_configuration
      end

      def init_required_fields
        self.required_fields = %i[field1]

        super
      end

      def populate_structure
        self.tree_structure = {
          root: {
            field1: field1,
            field2: field2
          }
        }
      end

    end
  end
end
