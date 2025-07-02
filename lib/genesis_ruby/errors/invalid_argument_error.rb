# frozen_string_literal: true

require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class InvalidArgumentError < Error

    def custom_message
      return 'The supplied argument is invalid for this method!' unless @message

      @message
    end

  end
end
