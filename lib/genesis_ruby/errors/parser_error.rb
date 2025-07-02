# frozen_string_literal: true

require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class ParserError < Error

    def custom_message
      return 'Unknown error during parsing the response!' unless @message

      @message
    end

  end
end
