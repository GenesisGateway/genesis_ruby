# frozen_string_literal: true

require 'genesis_ruby/errors/error'

module GenesisRuby
  # Invalid Argument Custom Error
  class ObjectFormatterError < Error

    def custom_message
      return 'Invalid format given!' unless @message

      @message
    end

  end
end
