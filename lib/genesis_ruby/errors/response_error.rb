require 'genesis_ruby/errors/error'

module GenesisRuby
  # Response Custom Error
  class ResponseError < Error

    def custom_message
      return 'Invalid/Unexpected format given! ' unless @message

      @message
    end

  end
end
