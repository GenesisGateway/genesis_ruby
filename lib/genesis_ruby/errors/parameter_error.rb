# frozen_string_literal: true

require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class ParameterError < Error

    def custom_message
      "Please verify the following transaction parameters:\n#{@message}"
    end

  end
end
