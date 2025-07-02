# frozen_string_literal: true

require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class NetworkError < Error

    def custom_message
      return 'Unknown error during network request!' unless @message

      @message
    end

  end
end
