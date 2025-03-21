require 'genesis_ruby/api/requests/base/versioned'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          # Versioned stub
          class VersionedStub < GenesisRuby::Api::Requests::Base::Versioned

            def initialize(configuration, builder_interface = 'json')
              super configuration, builder_interface

              self.request_path = 'fake_path'
            end

            protected

            def request_structure
              {}
            end

          end
        end
      end
    end
  end
end
