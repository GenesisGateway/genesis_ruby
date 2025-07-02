# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Identity Documents Module for handling document-related operations
            module IdentityDocumentAttributes

              MAX_DOCUMENTS = 4

              # Initializes the document attributes
              def docs
                @docs ||= []
              end

              # Adds a document with base64 content and MIME type
              def add_doc(base64_content, mime_type)
                if docs.size >= MAX_DOCUMENTS
                  raise GenesisRuby::InvalidArgumentError, "Maximum of #{MAX_DOCUMENTS} documents allowed"
                end

                docs << {
                  base64_content: base64_content,
                  mime_type:      mime_type
                }

                @docs
              end

              # Clears all documents and resets the base64 content and MIME type
              def clear_docs
                @docs = []
              end

              protected

              # Returns the document at the specified index
              def get_doc(index)
                docs[index.to_i]
              end

            end
          end
        end
      end
    end
  end
end
