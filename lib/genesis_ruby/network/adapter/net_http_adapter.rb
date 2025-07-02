# frozen_string_literal: true

require 'genesis_ruby/network/adapter/base_adapter'
require 'genesis_ruby/errors/network_error'
require 'net/http'

module GenesisRuby
  module Network
    module Adapter
      # Net-HTTP Adapter implementation
      class NetHttpAdapter < BaseAdapter

        # HTTP Response Status Code
        def status
          @response&.code
        end

        # Prepare the request from the given data
        def prepare_request(data)
          @request_data = data
          @uri          = parse_uri
          # Force connection re-creation
          @request      = Net::HTTP.start(@uri.hostname ||= '', ssl_options)
        end

        # Send the request
        def execute # rubocop:disable Metrics/AbcSize
          raise NetworkError, 'Request is not initialized' unless @request

          safe_execute do
            case request_data.type
            when Api::Request::METHOD_POST then @response = @request.post path, request_data.body, headers
            when Api::Request::METHOD_PUT then @response = @request.put path, request_data.body, headers
            when Api::Request::METHOD_GET then @response = @request.get path, headers
            else raise 'Invalid Request Type!'
            end
          end
        end

        # Response body
        def response_body
          @response_body ||= @response ? @response.body : ''
        end

        # Response headers
        def response_headers
          @response_headers ||= @response ? @response.each_header.to_h : {}
        end

        # Whether the response is an error (HTTP Code != 200)
        def error?
          !@response.is_a? Net::HTTPSuccess
        end

        # Response server message
        def server_message
          message = status
          message += " #{@response.message}" if @response.message

          message
        end

        private

        attr_reader :uri, :request, :response, :request_data

        # Path accessor that secure always string return value
        def path
          path = @uri&.path

          path += "?#{@uri.query}" if @uri.query

          path.empty? ? '/' : path
        end

        # Override URI parsing errors
        def parse_uri
          URI.parse(request_data.url)
        rescue URI::Error => e
          raise NetworkError, "Error during URL parsing: #{e.message}"
        end

        # Define SSL requirements
        def ssl_options
          {
            use_ssl:         true,
            verify_mode:     OpenSSL::SSL::VERIFY_PEER,
            verify_depth:    10,
            verify_hostname: true,
            read_timeout:    request_data.timeout,
            min_version:     OpenSSL::SSL::TLS1_VERSION
          }
        end

        # Define Headers
        def headers
          data = common_headers

          data.merge! payload_headers unless request_data.type == Api::Request::METHOD_GET
          data.merge! request_data.headers if request_data.headers.is_a?(Hash) && !request_data.headers.empty?

          data
        end

        # Provides default request headers
        def common_headers
          {
            'Authorization' => request_data.user_login.to_s,
            'User-Agent'    => request_data.user_agent.to_s
          }
        end

        # Payload Headers
        def payload_headers
          {
            'Content-Type'   => request_data.format,
            'Content-Length' => request_data.body&.length.to_s
          }
        end

        # Safe Request execution
        def safe_execute(&block)
          block.call
        rescue StandardError => e
          raise NetworkError, "Network error raised by #{e.class.name}: #{e.message}"
        ensure
          # Close the request
          @request.finish
        end

      end
    end
  end
end
