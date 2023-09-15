module GenesisRuby
  # Base Genesis Ruby Error
  class Error < StandardError

    # Predefined error message
    def custom_message
      @message
    end

    # Customer errors constructor
    def initialize(msg = nil)
      @message = msg

      super(custom_message)
    end

  end
end
