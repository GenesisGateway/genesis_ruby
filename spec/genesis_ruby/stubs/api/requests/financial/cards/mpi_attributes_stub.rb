module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            # Mpi Attributes Stub
            class MpiAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Cards::MpiAttributes

              public :mpi_attributes_structure

            end
          end
        end
      end
    end
  end
end
