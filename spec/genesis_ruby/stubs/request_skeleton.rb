# frozen_string_literal: true

require 'genesis_ruby/api/request'

module GenesisSpec
  module Stubs
    # Request Skeleton
    class RequestSkeleton < GenesisRuby::Api::Request

      def build_document
        File.open("#{File.dirname(__FILE__)}/../fixtures/requests/wpf_request.xml", 'rb').read
      end

      protected

      def init_configuration
        init_xml_configuration
        init_api_wpf_configuration
      end

    end
  end
end
