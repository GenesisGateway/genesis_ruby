require 'genesis_ruby/api/constants/transactions/parameters/mpi_protocol_versions'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Mixin Mpi Attributes
            module MpiAttributes

              attr_reader :mpi_threeds_challenge_indicator, :mpi_protocol_version
              attr_accessor :mpi_cavv, :mpi_eci, :mpi_xid, :mpi_directory_server_id,
                            :mpi_asc_transaction_id

              # The used 3DS protocol version. Default is 1 if not supplied.
              def mpi_protocol_version=(value)
                allowed_options(
                  attribute:   __method__,
                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::MpiProtocolVersions.all,
                  value:       value.to_i,
                  allow_empty: true
                )
              end

              # Optional value for 3DS challenge indicator. Highly recommended to increase approve ratio.
              def mpi_threeds_challenge_indicator=(value)
                allowed_indicators = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::
                    Control::ChallengeIndicators.all

                allowed_options attribute: __method__, allowed: allowed_indicators, value: value, allow_empty: true
              end

              protected

              # Mpi Attributes Structure
              def mpi_attributes_structure
                {
                  eci:                         mpi_eci,
                  cavv:                        mpi_cavv,
                  protocol_version:            mpi_protocol_version,
                  directory_server_id:         mpi_directory_server_id,
                  acs_transaction_id:          mpi_asc_transaction_id,
                  threeds_challenge_indicator: mpi_threeds_challenge_indicator
                }
              end

            end
          end
        end
      end
    end
  end
end
