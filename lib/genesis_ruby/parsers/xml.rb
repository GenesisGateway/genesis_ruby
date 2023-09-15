require 'genesis_ruby/parsers/base'
require 'nokogiri'

module GenesisRuby
  module Parsers
    # XML Document Parser
    class Xml < Base

      def parse_document(document)
        load_document(document)

        @structure = if root_node_skipped
                       collect_nodes(@document.root)
                     else
                       { @document.root.name.to_sym => collect_attributes(@document.root).merge(
                         collect_nodes(@document.root)
                       ) }
                     end
      end

      private

      attr_reader :document

      # Nokogiri::XML.parse
      def load_document(document)
        @document  = Nokogiri::XML.parse document, &:strict
      rescue Nokogiri::SyntaxError
        raise ParserError, 'Given Document is invalid'
      end

      # Loop the given Nokogiri::XML::Document
      def collect_nodes(nodes, tree = {})
        nodes.children.each do |child|
          next if skip_element?(child)

          tree[child.name.to_sym] = [tree[child.name.to_sym]] if duplicated_keys?(tree, child.name.to_sym)

          process_node(child, tree)
        end

        tree
      end

      # Process every node by checking the type of the given tree and take decision for further processing
      def process_node(node, tree)
        key = node.name.to_sym

        # The node has children of type Nokogiri::XML::Node.element?
        return tree[key] = collect_children(node, tree) if children_elements?(node)

        # The node is Element type and the tree has duplicated keys
        return tree[key].push format_element(node) if tree[key].is_a? Array

        # Simple Element formatting
        tree[key] = format_element(node)
      end

      # Handle Nokogiri::XML::Element and take decision for further processing
      def collect_children(child, tree)
        key       = child.name.to_sym
        tree[key] = collect_attributes(child) unless tree[key]

        case tree[key]
        when Array
          tree[key].push collect_attributes(child).merge collect_nodes(child, {})
        when Hash
          collect_nodes(child, tree[key])
        end
      end

      # Format Nokogiri::XML::Element element
      def format_element(element)
        attributes = collect_attributes(element)

        return element.content.to_s if attributes.empty? && !children_elements?(element)

        attributes.merge(
          element.content.to_s.empty? ? {} : { element.name.to_sym => element.content.to_s }
        )
      end

      # Collect attributes of the given Nokogiri::XML::Node
      def collect_attributes(element)
        attributes = {}

        element.attributes.each_value { |attribute| attributes.merge! format_attributes attribute }

        attributes
      end

      # Format Nokogiri::XML:Element.attributes
      def format_attributes(element)
        { element.name.to_sym => element.value.to_s }
      end

      # Check if the given tree already has definition of the given key
      def duplicated_keys?(tree, key)
        tree.is_a?(Hash) && tree.key?(key) && !tree[key].is_a?(Array)
      end

      # Check if the given element should be skipped
      def skip_element?(element)
        blank_element?(element) || element.comment? || element.cdata? || element.xml? || element.html?
      end

      # Check if the given Nokogiri::XML::Node has blank element (ex. "\n   ")
      # Doesn't remove <element/> as Genesis has such output (ex Chargeback cnn)
      def blank_element?(element)
        element.text? && element.content.strip.empty?
      end

      # Check if the given element has at least one child with Nokogiri::XML::Node.children of Element type
      def children_elements?(element)
        !element.children.find(&:element?).nil?
      end

    end
  end
end
