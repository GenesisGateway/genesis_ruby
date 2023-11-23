require 'genesis_ruby/utils/threeds/v2'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          module Threeds
            module V2
              # Method Continue API request
              class MethodContinue < Request

                include Mixins::Requests::Financial::PaymentAttributes
                include Mixins::Requests::RestrictedSetter

                attr_writer :url, :transaction_unique_id, :signature

                class << self

                  def build_from_response_object(configuration, response_object)
                    if response_object[:threeds_method_continue_url].nil? ||
                       response_object[:unique_id].nil? ||
                       response_object[:amount].nil? || response_object[:currency].nil? ||
                       response_object[:timestamp].nil? || !response_object[:timestamp].is_a?(DateTime)

                      raise ParameterError, 'Response object is incomplete or required attributes are missing!'
                    end

                    build_method_continue_request configuration, response_object
                  end

                  private

                  # Build Method Continue Request
                  def build_method_continue_request(configuration, response_object)
                    request = new configuration

                    request.url                   = response_object[:threeds_method_continue_url]
                    request.transaction_unique_id = response_object[:unique_id]
                    request.amount                = response_object[:amount]
                    request.currency              = response_object[:currency]
                    request.transaction_timestamp = response_object[:timestamp].strftime(
                      Constants::DateTimeFormats::YYYY_MM_DD_H_I_S_ZULU
                    )

                    GenesisRuby::Genesis.new configuration, request
                  end

                end

                # Override default constructor with FORM Builder Interface
                def initialize(configuration, _builder_interface = nil)
                  super(configuration, Builder::FORM)
                end

                # A link between the customer's browser and the card issuer must be opened with a hidden iframe
                def url
                  return @url = generate_endpoint_url if @url.nil?

                  @url
                end

                # Equivalent to the value of the unique_id,
                # received from the response of the initial transaction request
                def transaction_unique_id
                  return extract_unique_id_from_url @url if @transaction_unique_id.nil?

                  @transaction_unique_id
                end

                # SHA512 of а concatenated string (unique_id, amount, timestamp, merchant_api_password)
                def signature
                  return @signature unless @signature.nil?

                  payment_amount = @currency.nil? ? amount : transform_amount(amount, currency)

                  Utils::Threeds::V2.generate_signature(
                    unique_id: transaction_unique_id,
                    amount: payment_amount,
                    timestamp: transaction_timestamp,
                    merchant_password: @configuration.password
                  )
                end

                # The timestamp from the initial transaction response
                def transaction_timestamp
                  @transaction_timestamp&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S_ZULU
                  )
                end

                # The timestamp from the initial transaction response
                def transaction_timestamp=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                protected

                # Init Method Continue Request configuration
                def init_configuration
                  init_form_configuration

                  @api_config.type = Request::METHOD_PUT

                  init_api_gateway_configuration request_path: 'threeds/threeds_method/:unique_id', include_token: false
                end

                # Build correct endpoint url during runtime
                def process_request_parameters
                  @api_config.url = url

                  super
                end

                # Method Continue Request structure
                def populate_structure
                  @tree_structure = {
                    unique_id: transaction_unique_id,
                    signature: signature
                  }
                end

                private

                # Fills the Unique Id in the endpoint URL
                def generate_endpoint_url
                  @api_config.url&.sub! ':unique_id', transaction_unique_id.to_s
                end

                # Extract the Unique Id
                def extract_unique_id_from_url(url)
                  uri           = URI.parse url || ''
                  exploded_path = uri.path&.split('/')

                  exploded_path.last
                end

              end
            end
          end
        end
      end
    end
  end
end
