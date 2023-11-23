module GenesisRuby
  module Network
    module Adapter
      # Base Network Adapter Class
      class BaseAdapter

        # Response body is plain string received from the server
        # Response header is hash with the received headers from the server
        attr_accessor :response_body, :response_headers

        # Retrieve HTTP Response Status Code
        def status
          raise NotImplementedError, 'Status method must be implemented'
        end

        # Prepare the Request
        # Return the adapter library request object
        def prepare_request(data)
          raise NotImplementedError, 'Prepare Request Body method must be implemented'
        end

        # Execute the request
        # Return the adapter library response object
        def execute
          raise NotImplementedError, 'Execute method must be implemented'
        end

        # Whether the response is an error (HTTP Code != 200)
        def error?
          raise NotImplementedError, 'Error? method must be implemented'
        end

        # Response server message
        def server_message
          raise NotImplementedError, 'Server Message method must be implemented'
        end

      end
    end
  end
end
