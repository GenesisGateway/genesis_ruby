module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Base
          # GraphQL stub
          class GraphqlStub < GenesisRuby::Api::Requests::Base::Graphql

            def initialize(configuration, builder_interface = 'graphql')
              super configuration, builder_interface

              self.request_path = 'billing_transactions'
              self.request_name = 'billingTransactions'
              self.root_key     = 'query'
            end

            attr_accessor :start_date, :end_date, :unique_id, :billing_statement, :transaction_type, :items,
                          :order_by_direction, :order_by_field, :page, :per_page, :paging

            protected

            def init_authorization_token
              api_config.bearer_token = configuration.billing_api_token
            end

            def query_filters
              { filter: {
                  billingStatement: billing_statement,
                  startDate:        start_date,
                  endDate:          end_date,
                  uniqueId:         unique_id,
                  transactionType:  transaction_type
                },
                paging: { page: page, perPage: per_page },
                sort:   { byDirection: order_by_direction, byField: order_by_field } }
            end

            def query_response_fields
              {
                items:  items,
                paging: paging
              }
            end

          end
        end
      end
    end
  end
end
