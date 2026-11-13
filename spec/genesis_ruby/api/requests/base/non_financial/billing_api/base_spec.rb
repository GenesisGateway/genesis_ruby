# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Base::NonFinancial::BillingApi::Base do
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) { described_class.new config }

  describe 'when escape_graphql_string' do
    it 'with plain value returns the value unchanged' do
      expect(request.__send__(:escape_graphql_string, 'plain')).to eq 'plain'
    end

    it 'with a double-quote escapes the quote' do
      expect(request.__send__(:escape_graphql_string, 'a"b')).to eq 'a\\"b'
    end

    it 'with a backslash doubles the backslash' do
      expect(request.__send__(:escape_graphql_string, 'a\\b')).to eq 'a\\\\b'
    end

    it 'with a backslash followed by a double-quote escapes the backslash first' do
      expect(request.__send__(:escape_graphql_string, 'a\\"b')).to eq 'a\\\\\\"b'
    end

    it 'with an empty string returns an empty string' do
      expect(request.__send__(:escape_graphql_string, '')).to eq ''
    end
  end

  describe 'when format_string_list' do
    it 'with multiple values renders a comma-separated list literal without whitespace' do
      expect(request.__send__(:format_string_list, %w(a b))).to eq '["a","b"]'
    end

    it 'with a single value renders a single-element list literal' do
      expect(request.__send__(:format_string_list, ['a'])).to eq '["a"]'
    end

    it 'with values containing a double-quote escapes each element' do
      expect(request.__send__(:format_string_list, ['a"b'])).to eq '["a\\"b"]'
    end

    it 'with values containing a backslash then a double-quote escapes the backslash first' do
      expect(request.__send__(:format_string_list, ['a\\"b'])).to eq '["a\\\\\\"b"]'
    end

    it 'with an empty array renders an empty list literal' do
      expect(request.__send__(:format_string_list, [])).to eq '[]'
    end
  end

  # Task 11.1: GraphQL escaping and list-literal helpers (Requirements 4.2, 8.1, 8.2, 8.3, 8.4, 10.7)
  describe 'when rendering GraphQL escaping and list literals' do
    it 'escapes a double-quote inside a scalar value' do
      expect(request.__send__(:escape_graphql_string, 'a"b')).to eq 'a\\"b'
    end

    it 'doubles a backslash inside a scalar value' do
      expect(request.__send__(:escape_graphql_string, 'a\\b')).to eq 'a\\\\b'
    end

    it 'escapes the backslash before the double-quote when a backslash precedes a quote' do
      expect(request.__send__(:escape_graphql_string, 'a\\"b')).to eq 'a\\\\\\"b'
    end

    it 'renders an array as a comma-separated list literal without whitespace' do
      expect(request.__send__(:format_string_list, %w(a b))).to eq '["a","b"]'
    end
  end

  # Task 20.2: escape the GraphQL control characters (R13.10)
  describe 'when escaping control characters' do
    it 'escapes a newline as backslash + n and leaves no raw newline' do # rubocop:disable RSpec/MultipleExpectations
      result = request.__send__(:escape_graphql_string, "a#{10.chr}b")

      expect(result).to eq 'a\\nb'
      expect(result).to_not include "\n"
    end

    it 'escapes a carriage return as backslash + r and leaves no raw carriage return' do # rubocop:disable RSpec/MultipleExpectations
      result = request.__send__(:escape_graphql_string, "a#{13.chr}b")

      expect(result).to eq 'a\\rb'
      expect(result).to_not include "\r"
    end

    it 'escapes a tab as backslash + t and leaves no raw tab' do # rubocop:disable RSpec/MultipleExpectations
      result = request.__send__(:escape_graphql_string, "a#{9.chr}b")

      expect(result).to eq 'a\\tb'
      expect(result).to_not include "\t"
    end

    it 'escapes a backspace as backslash + b and leaves no raw backspace' do # rubocop:disable RSpec/MultipleExpectations
      result = request.__send__(:escape_graphql_string, "a#{8.chr}b")

      expect(result).to eq 'a\\bb'
      expect(result).to_not include 8.chr
    end

    it 'escapes a form feed as backslash + f and leaves no raw form feed' do # rubocop:disable RSpec/MultipleExpectations
      result = request.__send__(:escape_graphql_string, "a#{12.chr}b")

      expect(result).to eq 'a\\fb'
      expect(result).to_not include "\f"
    end

    it 'escapes a mixed backslash, double-quote and newline in order' do
      input    = "x#{92.chr}#{34.chr}#{10.chr}y"
      expected = "x#{92.chr}#{92.chr}#{92.chr}#{34.chr}#{92.chr}ny"

      expect(request.__send__(:escape_graphql_string, input)).to eq expected
    end

    it 'doubles a literal backslash followed by the letter n instead of producing a newline escape' do # rubocop:disable RSpec/MultipleExpectations
      result        = request.__send__(:escape_graphql_string, "a#{92.chr}nb")
      newline_value = request.__send__(:escape_graphql_string, "a#{10.chr}b")

      expect(result).to eq "a#{92.chr}#{92.chr}nb"
      expect(result).to_not eq newline_value
    end

    it 'returns a plain value unchanged' do
      expect(request.__send__(:escape_graphql_string, 'plain-123')).to eq 'plain-123'
    end

    it 'escapes a control character inside a list literal element' do
      expect(request.__send__(:format_string_list, ["a#{10.chr}b"])).to eq '["a\\nb"]'
    end
  end
end
