require 'genesis_ruby/api/constants/transactions/parameters/mobile/apple_pay/payment_subtypes'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Mobile
          # Apple Pay transaction request
          class ApplePay < Requests::Base::Financial

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::BirthDateAttributes
            include Mixins::Requests::DocumentAttributes
            include Mixins::Requests::Financial::Business::BusinessAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringTypeAttributes
            include Mixins::Requests::Financial::CryptoAttributes
            include Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Mixins::Requests::Financial::Mobile::ApplePayTokenAttributes
            include Mixins::Requests::Financial::PaymentAttributes

            attr_accessor :payment_subtype

            # Define Payment Token from a JSON string
            def json_token=(value)
              json_object = Utils::Common.parse_json_string value

              map_apple_pay_token_attributes json_object
            end

            protected

            # Apple Pay transaction request type
            def transaction_type
              Api::Constants::Transactions::APPLE_PAY
            end

            def init_field_validations
              required_fields.push *%i[transaction_id payment_subtype token_version token_data token_signature
                token_ephemeral_public_key token_public_key_hash token_transaction_id token_display_name token_network
                token_type token_transaction_identifier amount currency]

              field_values.merge! currency:        Api::Constants::Currencies::Iso4217.all.map(&:upcase),
                                  payment_subtype: Api::Constants::Transactions::Parameters::Mobile::ApplePay::
                                      PaymentSubtypes.all,
                                  recurring_type:  [Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL]
            end

            # Apple Pay payment transaction structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              payment_attributes_structure.merge(
                {
                  payment_subtype:           payment_subtype,
                  payment_token:             payment_token_structure,
                  customer_email:            customer_email,
                  customer_phone:            customer_phone,
                  birth_date:                birth_date,
                  billing_address:           billing_address_parameters_structure,
                  shipping_address:          shipping_address_parameters_structure,
                  document_id:               document_id,
                  crypto:                    crypto,
                  recurring_type:            recurring_type,
                  business_attributes:       business_attributes_structure,
                  dynamic_descriptor_params: dynamic_descriptor_structure
                }
              )
            end

            private

            # Map the Apple Pay Token attributes from the given Hash object
            def map_apple_pay_token_attributes(json_object)
              return nil unless json_object.is_a? Hash

              json_object.each do |token_key, token_value|
                if token_value.is_a? Hash
                  map_apple_pay_token_attributes token_value

                  next
                end

                token_method = "token_#{GenesisRuby::Utils::Common.camel_to_snake_case(token_key)}="

                __send__ token_method, token_value if respond_to? token_method
              end

              nil
            end

          end
        end
      end
    end
  end
end
