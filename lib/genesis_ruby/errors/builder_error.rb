require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class BuilderError < Error

    def custom_message
      return 'Unknown error during building the request!' unless @message

      @message
    end

  end
end
