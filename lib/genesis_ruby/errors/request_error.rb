require 'genesis_ruby/errors/error'

module GenesisRuby
  # Response Custom Error
  class RequestError < Error

    def custom_message
      return 'Invalid argument given! ' unless @message

      @message
    end

  end
end
