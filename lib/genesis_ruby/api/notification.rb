# frozen_string_literal: true

require 'cgi'
require 'digest'

module GenesisRuby
  module Api
    # Gateway Notification handler
    class Notification

      attr_reader :unique_id, :notification, :reconciliation

      # Signature algorithms
      SHA1_SIGNATURE_TYPE   = 'SHA1'
      SHA256_SIGNATURE_TYPE = 'SHA256'
      SHA512_SIGNATURE_TYPE = 'SHA512'

      # Possible request/response identifier fields
      API_UNIQUE_FIELD = 'unique_id'
      WPF_UNIQUE_FIELD = 'wpf_unique_id'
      KYC_UNIQUE_FIELD = 'reference_id'

      # Class constructor
      def initialize(configuration, data)
        @configuration = configuration

        parse_notification data
      end

      # Check if the given data is API notification
      def api_notification?
        notification.key? :unique_id
      end

      # Check if the given data is Web Payment Form notification
      def wpf_notification?
        notification.key? :wpf_unique_id
      end

      # Check if the given data is Know Your Customer notification
      def kyc_notification?
        notification.key? :reference_id
      end

      # Generates XML document expected from the Gateway
      def generate_response
        response = {
          notification_echo: [[fetch_response_unique_field, unique_id]].to_h
        }

        builder = GenesisRuby::Builder.new Builder::XML
        builder.parse_structure response

        builder.document
      end

      # Execute Reconcile API Request
      def reconcile
        request_object = fetch_reconciliation_request

        begin
          genesis = Genesis.for config: @configuration, request: request_object do |req|
            req.unique_id = unique_id
          end.execute

          @reconciliation = genesis.response
        rescue Error
          @reconciliation = nil
        end
      end

      # Determinate if the executed reconciliation response contains transaction data
      def transaction_reconciliation?
        response_object = reconciliation&.response_object

        return false if response_object.nil?

        response_object.key?(:unique_id) && response_object.key?(:transaction_id) && response_object.key?(:status)
      end

      private

      # Parse the given notification data
      def parse_notification(data, authenticate: true)
        @notification = parse_raw_data data
        @unique_id    = fetch_unique_id

        raise ParameterError, 'Invalid Genesis Notification!' if authenticate && !authentic?
      end

      # Parse the given raw data
      def parse_raw_data(data)
        normalize_data data.to_h
      rescue StandardError => e
        raise ParameterError, "Given notification data doesn't respond to_h! #{e.message}"
      end

      # Normalize the given notification data
      def normalize_data(data)
        data.map { |key, value| [CGI.unescape(key.to_s).to_sym, CGI.unescape(value.strip)] }.to_h
      end

      # Assign the unique_id property based on the given notification data
      def fetch_unique_id
        return @notification[API_UNIQUE_FIELD.to_sym] if api_notification?
        return @notification[WPF_UNIQUE_FIELD.to_sym] if wpf_notification?
        return @notification[KYC_UNIQUE_FIELD.to_sym] if kyc_notification?

        nil
      end

      # Validate the Notification signature
      def authentic?
        if unique_id.nil? || notification[:signature].nil?
          raise ParameterError, 'Missing Notification attributes: unique_id or signature'
        end

        generated_signature = fetch_signature_generator.hexdigest "#{unique_id}#{@configuration.password}"

        notification[:signature] == generated_signature
      end

      # Fetch the hash generator based on the hash type
      def fetch_signature_generator
        Digest.const_get fetch_hash_type
      end

      # Fetch the hash algorithm by the given signature length
      def fetch_hash_type
        case notification[:signature].length
        when 40 then SHA1_SIGNATURE_TYPE
        when 64 then SHA256_SIGNATURE_TYPE
        when 128 then SHA512_SIGNATURE_TYPE
        else
          SHA1_SIGNATURE_TYPE
        end
      end

      # Fetches the response field identifier name witch is expected from the Gateway
      def fetch_response_unique_field
        return API_UNIQUE_FIELD if api_notification?
        return WPF_UNIQUE_FIELD if wpf_notification?
        return KYC_UNIQUE_FIELD if kyc_notification?

        raise ParameterError, 'Unknown notification type!'
      end

      # Fetch the Reconcile object
      def fetch_reconciliation_request
        return Requests::NonFinancial::Reconcile::Transaction if api_notification?
        return Requests::Wpf::Reconcile if wpf_notification?

        raise ParameterError, 'Unsupported notification type for Reconciliation'
      end

    end
  end
end
