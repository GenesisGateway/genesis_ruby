# frozen_string_literal: true

require 'genesis_ruby/api/requests/base/consumer'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          # Consumer stub
          class ConsumerStub < GenesisRuby::Api::Requests::Base::Consumer

            def initialize(configuration, _builder_interface = 'xml')
              super configuration

              self.request_path = 'fake_path'
            end

            protected

            def request_structure
              {
                field: 'value'
              }
            end

          end
        end
      end
    end
  end
end
