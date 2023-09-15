require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class EndpointNotSetError < Error

    def custom_message
      return 'No working endpoint has been set, please choose between emp/ecp endpoint!' unless @message

      @message
    end

  end
end
