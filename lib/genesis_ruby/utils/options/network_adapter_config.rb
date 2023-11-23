require 'genesis_ruby/utils/options/base'

module GenesisRuby
  module Utils
    module Options
      # Configurable Options used for the API Request configuration
      class NetworkAdapterConfig < Base

        # Map the Adapter configuration from the Request object
        def map_from_request(request) # rubocop:disable Metrics/AbcSize
          self.body     = request.build_document
          self.url      = request.api_config.url
          self.type     = request.api_config.type
          self.port     = request.api_config.port
          self.protocol = request.api_config.protocol
          self.format   = fetch_content_type(request.api_config.format)

          self
        end

        protected

        # Retrieve the Request data format that must be used as Content-Type header
        def fetch_content_type(data_format)
          case data_format
          when Builder::XML
            'text/xml'
          when Builder::JSON
            'application/json'
          when Builder::FORM
            'application/x-www-form-urlencoded'
          else
            raise InvalidArgumentError, 'Invalid request format type. Allowed are XML, JSON and FORM'
          end
        end

      end
    end
  end
end
