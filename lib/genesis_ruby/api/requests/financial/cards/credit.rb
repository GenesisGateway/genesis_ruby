module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Credits (also known as Credit Fund Transfer a.k.a. CFT) can be done with an initial reference transaction.
          class Credit < Requests::Base::Reference

            include Mixins::Requests::Financial::Cards::AccountOwnerAttributes
            include Mixins::Requests::Financial::CustomerIdentificationAttributes
            include Mixins::Requests::Financial::PurposeOfPaymentAttributes
            include Mixins::Requests::Financial::SourceOfFundsAttributes
            include Mixins::Requests::Financial::CryptoAttributes
            include Mixins::Requests::DigitalAssetTypeAttributes

            protected

            # Credit transaction type
            def transaction_type
              Api::Constants::Transactions::CREDIT
            end

            # Reference transaction structure
            def reference_transaction_structure
              {
                'crypto'                  => crypto,
                'digital_asset_type'      => digital_asset_type,
                'customer_identification' => customer_identification_attributes_structure,
                'account_owner'           => account_owner_attributes_structure,
                'purpose_of_payment'      => purpose_of_payment
              }.merge source_of_funds_attributes_structure
            end

          end
        end
      end
    end
  end
end
