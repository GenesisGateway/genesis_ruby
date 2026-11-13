# frozen_string_literal: true

require 'genesis_ruby/builders/base'
require 'json'

module GenesisRuby
  module Builders
    # GraphQL builder
    class Graphql < Base

      # Builder GraphQL constructor
      def initialize
        @document = ''
        super
      end

      # Outputs generated document
      def output
        @document
      end

      # Created GraphQL query from provided structure
      def populate_nodes(structure)
        validate_structure(structure)

        @document = build_query(structure)
      end

      private

      # Validates given structure
      def validate_structure(structure)
        raise BuilderError, 'Invalid Hash structure given in Graphql builder!' unless structure.is_a? Hash

        root_key = structure.keys.first

        raise BuilderError, 'Missing structure root key in Graphql builder' if root_key.nil?
        raise BuilderError, 'Invalid GraphQL structure given in GraphQL builder' unless structure[root_key].is_a? Hash
      end

      # Sort keys are GraphQL ENUM tokens and are always rendered without surrounding quotes
      DEFAULT_BARE_KEYS = %w(byDirection byField).freeze

      # Build GraphQL Query
      def build_query(structure)
        ident           = ' ' * 2
        root_key        = structure.keys.first
        node            = structure[root_key]
        filters         = build_filters node[:filters], bare_keys(node)
        response_fields = build_response_fields node[:response_fields], ident * 2

        format("%{root} {\n#{ident}%{action}(%{filters})\n#{ident}{\n%{response_fields}\n#{ident}}\n}",
               root:            root_key,
               action:          node[:action].to_s,
               filters:         filters,
               response_fields: response_fields)
      end

      # Collects the filter keys that must be rendered without quotes (sort ENUMs + request-provided)
      def bare_keys(node)
        DEFAULT_BARE_KEYS | Array(node[:filters_without_quotes]).map(&:to_s)
      end

      # Build GraphQL filters. Each top-level block (filter, sort, paging) is rendered and
      # empty blocks are omitted entirely.
      def build_filters(data, bare_keys = [])
        return '' unless data.is_a? Hash

        data.filter_map { |key, value| splat_hash(Hash[key, value], bare_keys) }.join(', ')
      end

      # Builds a filter block in the GraphQL syntax.
      # { key: { key1: 'value1', key2: ['a', 'b'] } } becomes key: { key1: "value1", key2: ["a","b"] }
      # Empty-string and empty-array arguments are omitted. Returns nil for an empty block so the
      # whole block is dropped by build_filters.
      def splat_hash(data, bare_keys = [])
        root_key = data.keys.first

        return nil unless data[root_key].is_a? Hash

        inner = data[root_key].filter_map do |key, value|
          rendered = render_filter_value value, bare_keys.include?(key.to_s)
          next nil if rendered.nil?

          format '%{key}: %{value}', key: key.to_s, value: rendered
        end

        return nil if inner.empty?

        format '%{key}: { %{out} }', key: root_key, out: inner.join(', ')
      end

      # Renders a single filter value.
      # - nil / empty string / empty array -> nil (argument omitted)
      # - Array -> quoted+escaped list literal: ["a","b"]
      # - Numeric -> rendered bare (e.g. page: 2, perPage: 100)
      # - bare ENUM token -> rendered unquoted (scalar ENUM filters such as status / sort fields)
      # - scalar -> quoted + escaped
      def render_filter_value(value, bare_enum)
        return nil if value.nil?
        return nil if value.respond_to?(:empty?) && value.empty?
        return format_string_list(value) if value.is_a?(Array)
        return value.to_s if value.is_a?(Numeric) || bare_enum

        %("#{escape_graphql_string(value)}")
      end

      # GraphQL string escape table. Backslash MUST stay first so the backslashes
      # introduced by the other sequences are not escaped a second time.
      GRAPHQL_STRING_ESCAPES = {
        '\\' => '\\\\',
        '"'  => '\\"',
        "\n" => '\\n',
        "\r" => '\\r',
        "\t" => '\\t',
        "\b" => '\\b',
        "\f" => '\\f'
      }.freeze

      # Escape a scalar for embedding inside GraphQL double quotes.
      # Escapes backslash, double-quote and the five control characters in a single
      # left-to-right pass so a raw \" becomes \\\" without double-escaping.
      def escape_graphql_string(value)
        value.to_s.gsub(/[\\"\n\r\t\b\f]/, GRAPHQL_STRING_ESCAPES)
      end

      # Render an Array of values as a GraphQL list literal: ["a","b"]
      # Each element is individually escaped and double-quoted, comma-separated, no whitespace.
      def format_string_list(values)
        inner = values.map { |value| %("#{escape_graphql_string(value)}") }.join(',')

        "[#{inner}]"
      end

      # Build GraphQL query response fields
      def build_response_fields(data, ident)
        return '' unless data.is_a? Hash

        data.map { |key, selection| render_field_group key, selection, ident }.join("\n")
      end

      # Renders a top-level response-field group (e.g. items / paging) with its sub-selection
      #   items
      #   {
      #     item1
      #     item2
      #   }
      def render_field_group(key, selection, ident)
        inner = render_selection selection, "#{ident}  "

        format "#{ident}%{key}\n#{ident}{\n%{inner}\n#{ident}}", key: key, inner: inner
      end

      # Renders an array of selection nodes at the given indentation
      def render_selection(selection, ident)
        raise BuilderError, 'Empty response-field selection given in Graphql builder' if selection.to_a.empty?

        selection.map { |node| render_node node, ident }.join("\n")
      end

      # Renders a single selection node: a flat String/Symbol leaf or a single-key Hash sub-selection
      def render_node(node, ident)
        return "#{ident}#{node}" if node.is_a?(String) || node.is_a?(Symbol)

        name = node.keys.first
        sub  = node.values.first

        raise BuilderError, "Empty sub-selection for #{name} in Graphql builder" if sub.to_a.empty?

        format "#{ident}%{name}\n#{ident}{\n%{inner}\n#{ident}}", name: name, inner: render_selection(sub, "#{ident}  ")
      end

    end
  end
end
