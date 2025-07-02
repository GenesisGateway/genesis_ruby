# frozen_string_literal: true

require 'genesis_ruby/builders/base'
require 'nokogiri'

module GenesisRuby
  module Builders
    # XML, Nokogiri Builder Implementation
    class Xml < Base

      # Initialize Nokogiri XML Builder
      def initialize
        @builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8')
        super
      end

      # Generated XMl Document
      def output
        builder.to_xml
      end

      def populate_nodes(structure)
        root_element, data = if structure.length == 1
                               [structure.keys.first, structure.values.first]
                             else
                               ['root', structure.values.first]
                             end

        builder.method_missing(root_element, fetch_attributes(data)) { |xml| generate(data) } unless data.nil? # rubocop:disable Lint/UnusedBlockArgument
      end

      private

      attr_reader :builder

      # Loop the Hash and build the XML Document
      def generate(data)
        data.each do |element_name, element_value|
          if element_name.is_a?(Hash)
            populate_nodes(element_name)
          elsif element_value.is_a?(Array) || element_value.is_a?(Hash)
            add_node element_name, element_value, fetch_attributes(element_value)
          else
            add_element element_name, element_value
          end
        end
      end

      # Add node
      # Every node can be
      #   - Hash
      #   - Array of hashes
      def add_node(node_name, node_data, attributes = {})
        builder.method_missing(node_name, attributes) do
          node_data.each do |element_name, element_value|
            fetch_node element_name, element_value
          end
        end
      end

      # Check current node and execute build step
      def fetch_node(element_name, element_value)
        if element_name.is_a?(Hash)
          populate_nodes element_name
        elsif element_value.is_a?(Hash)
          add_node element_name, element_value, fetch_attributes(element_value)
        elsif element_value.is_a?(Array)
          build_array element_name, element_value
        else
          add_element element_name, element_value
        end
      end

      # Add a single element/tag to the XML Document
      def add_element(name, value, attributes = {})
        builder.method_missing(name, attributes, value)
      end

      # Fetch the attributes stored under the @attributes key
      def fetch_attributes(element_value)
        attributes = {}
        attributes = element_value.fetch('@attributes'.to_sym, {}) if element_value.is_a?(Hash)
        element_value.delete('@attributes'.to_sym)

        attributes
      end

      # Build XMl Document part from Array
      def build_array(element_name, element_value)
        element_value.each do |tag_value|
          if tag_value.is_a? Hash
            add_node element_name, tag_value

            next
          end

          add_element element_name, tag_value
        end
      end

    end
  end
end
