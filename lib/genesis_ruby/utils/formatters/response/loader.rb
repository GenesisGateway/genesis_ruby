# frozen_string_literal: true

require 'genesis_ruby/utils/formatters/response/definitions'

module GenesisRuby
  module Utils
    module Formatters
      module Response
        # Response Formatter initializer
        class Loader

          include Response

          # Load the Available Formatters
          def initialize
            initialize_formatters
          end

          # Initialized Formatters array
          def formats
            @formats ||= []
          end

          # Add new formatter to the formatter array
          def formats=(formatter_class)
            @formats = formats

            @formats.push formatter_class
          end

          private

          # Initialize the Available Formatters
          def initialize_formatters
            available_formatters.each do |formatter_class|
              self.formats = formatter_class.new
            end
          end

        end
      end
    end
  end
end
