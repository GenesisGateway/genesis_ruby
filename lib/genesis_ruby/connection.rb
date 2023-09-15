require 'genesis_ruby/network/net_http'
require 'genesis_ruby/errors/network_error'
require 'genesis_ruby/configuration'

module GenesisRuby
  # Prepare the Network connection used for sending the current request
  class Connection

    # Initialize Network Factory based on the Configuration
    def self.for(configuration)
      case configuration.interface
      when GenesisRuby::Configuration::NETWORK_INTERFACE_NET_HTTP
        GenesisRuby::Network::NetHttp.new(configuration)
      else
        raise GenesisRuby::NetworkError, 'Invalid network interface given.'
      end
    end

  end
end
