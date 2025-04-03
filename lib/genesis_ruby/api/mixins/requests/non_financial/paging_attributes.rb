module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Paging Attributes mixin
          module PagingAttributes

            attr_reader :page, :per_page

            # Page accessor
            def page=(value)
              parse_int attribute: __method__, value: value, allow_empty: true
            end

            # Per Page accessor
            def per_page=(value)
              parse_int attribute: __method__, value: value, allow_empty: true
            end

            protected

            # Paging Response fields
            def paging_query_fields
              %w(page perPage pagesCount totalCount)
            end

          end
        end
      end
    end
  end
end
