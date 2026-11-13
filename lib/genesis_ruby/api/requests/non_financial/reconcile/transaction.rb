# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Reconcile can be used to retrieve data about a transaction.
          # This can be useful if you want to retrieve information about a transaction whose status is timeout,
          # which returned an error or has changed eg. has beed chargebacked.
          class Transaction < Api::Requests::Base::NonFinancial::Reconcile::Base

            attr_accessor :arn, :transaction_id, :unique_id

            protected

            # API Request structure
            def populate_structure
              @tree_structure = {
                reconcile: {
                  arn:            arn,
                  transaction_id: transaction_id,
                  unique_id:      unique_id
                }
              }
            end

          end
        end
      end
    end
  end
end
