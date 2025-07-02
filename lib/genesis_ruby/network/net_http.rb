# frozen_string_literal: true

require 'genesis_ruby/network/base_network'
require 'genesis_ruby/network/adapter/net_http_adapter'

module GenesisRuby
  module Network
    # Net HTTP Network module
    class NetHttp < BaseNetwork

      # JSON Response Type
      def xml?
        response_headers['content-type'].downcase.include?(BaseNetwork::XML_HEADER)
      end

      # JSON Response Type
      def json?
        response_headers['content-type'].downcase.include?(BaseNetwork::JSON_HEADER)
      end

      # HTML Response Type
      def html?
        response_headers['content-type'].downcase.include?(BaseNetwork::HTML_HEADER)
      end

      protected

      # Adapter Initialization
      def factory
        GenesisRuby::Network::Adapter::NetHttpAdapter.new
      end

    end
  end
end
