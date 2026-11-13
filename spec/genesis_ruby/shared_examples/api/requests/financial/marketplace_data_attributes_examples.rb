# frozen_string_literal: true

require 'bigdecimal'
require 'nokogiri'

RSpec.shared_examples 'marketplace data attributes examples' do
  describe 'when marketplace data attributes' do
    let(:foreign_retailer) do
      GenesisRuby::Api::Constants::Transactions::Parameters::ForeignRetailerIndicators::FOREIGN_RETAILER
    end
    let(:marketplace_xml) { Nokogiri::XML(request.build_document) }
    let(:marketplace_build_error) do
      request.build_document

      nil
    rescue GenesisRuby::ParameterError => e
      e
    end
    let(:rendered_foreign_amount) do
      marketplace_xml.xpath('/payment_transaction/marketplace_data/foreign_retailer_transaction_amount').text
    end

    before do
      request.amount   = '100.00'
      request.currency = 'EUR'
    end

    describe 'with defaults and accessors' do
      it 'has nil foreign_retailer_indicator by default' do
        expect(described_class.new(config).foreign_retailer_indicator).to be_nil
      end

      it 'has nil foreign_retailer_transaction_amount by default' do
        expect(described_class.new(config).foreign_retailer_transaction_amount).to be_nil
      end

      ['F', 'f', 1, 1.5, BigDecimal('1'), true, [], {}].each do |value|
        it "stores foreign_retailer_indicator #{value.inspect} unchanged" do
          request.foreign_retailer_indicator = value

          expect(request.foreign_retailer_indicator).to eq value
        end

        it "stores foreign_retailer_transaction_amount #{value.inspect} unchanged" do
          request.foreign_retailer_transaction_amount = value

          expect(request.foreign_retailer_transaction_amount).to eq value
        end
      end

      it 'clears foreign_retailer_indicator with nil' do
        request.foreign_retailer_indicator = 'F'
        request.foreign_retailer_indicator = nil

        expect(request.foreign_retailer_indicator).to be_nil
      end

      it 'clears foreign_retailer_transaction_amount with nil' do
        request.foreign_retailer_transaction_amount = '10.50'
        request.foreign_retailer_transaction_amount = nil

        expect(request.foreign_retailer_transaction_amount).to be_nil
      end

      it 'returns foreign_retailer_transaction_amount in major units after build' do
        request.foreign_retailer_indicator          = foreign_retailer
        request.foreign_retailer_transaction_amount = 10.50
        request.build_document

        expect(request.foreign_retailer_transaction_amount).to eq 10.50
      end

      it 'does not convert the String foreign_retailer_transaction_amount reader value' do
        request.foreign_retailer_indicator          = foreign_retailer
        request.foreign_retailer_transaction_amount = '10.50'
        request.build_document

        expect(request.foreign_retailer_transaction_amount).to eq '10.50'
      end
    end

    describe 'with passing validation' do
      it 'passes with indicator F without amount' do
        request.foreign_retailer_indicator = foreign_retailer

        expect { request.build_document }.to_not raise_error
      end

      it 'passes without marketplace data attributes' do
        expect { request.build_document }.to_not raise_error
      end

      it 'passes with empty marketplace data attributes' do
        request.foreign_retailer_indicator          = ''
        request.foreign_retailer_transaction_amount = ''

        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'with the README example values' do
      it 'builds the document and renders the foreign amount in minor units' do
        request.foreign_retailer_indicator          = foreign_retailer
        request.foreign_retailer_transaction_amount = '25.50'

        expect(rendered_foreign_amount).to eq '2550'
      end
    end

    describe 'with initial recurring type' do
      before do
        request.recurring_type             =
          GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL
        request.foreign_retailer_indicator = foreign_retailer
      end

      it 'renders marketplace data together with the initial recurring type' do
        request.foreign_retailer_transaction_amount = '25.50'

        expect([marketplace_xml.xpath('/payment_transaction/recurring_type').text, rendered_foreign_amount])
          .to eq %w(initial 2550)
      end

      it 'raises when the foreign amount is greater than amount' do
        request.foreign_retailer_transaction_amount = '100.01'

        expect { request.build_document }
          .to raise_error GenesisRuby::ParameterError, /foreign_retailer_transaction_amount/
      end
    end

    describe 'with boundaries' do
      before { request.foreign_retailer_indicator = foreign_retailer }

      %w(99.99 100.00).each do |value|
        it "passes with foreign amount #{value}" do
          request.foreign_retailer_transaction_amount = value

          expect { request.build_document }.to_not raise_error
        end
      end

      it 'raises with foreign amount 100.01' do
        request.foreign_retailer_transaction_amount = '100.01'

        expect { request.build_document }
          .to raise_error GenesisRuby::ParameterError, /foreign_retailer_transaction_amount/
      end
    end

    describe 'with currency exponents' do
      before { request.foreign_retailer_indicator = foreign_retailer }

      [
        ['JPY', '1000', '100', '100'],
        ['EUR', '100.00', '10.50', '1050'],
        ['BHD', '100.000', '10.505', '10505']
      ].each do |currency, amount, foreign_amount, expected|
        it "renders #{foreign_amount} #{currency} as #{expected}" do
          request.currency                            = currency
          request.amount                              = amount
          request.foreign_retailer_transaction_amount = foreign_amount

          expect(rendered_foreign_amount).to eq expected
        end
      end

      [
        ['JPY', '1000', '10.5'],
        ['EUR', '100.00', '10.505'],
        ['BHD', '100.000', '10.5055']
      ].each do |currency, amount, foreign_amount|
        it "raises with over-precision #{foreign_amount} #{currency}" do
          request.currency                            = currency
          request.amount                              = amount
          request.foreign_retailer_transaction_amount = foreign_amount

          expect { request.build_document }
            .to raise_error GenesisRuby::ParameterError, /foreign_retailer_transaction_amount/
        end
      end
    end

    describe 'with input types' do
      before { request.foreign_retailer_indicator = foreign_retailer }

      [
        [BigDecimal('10.50'), '1050'],
        [10, '1000'],
        [10.5, '1050']
      ].each do |foreign_amount, expected|
        it "renders #{foreign_amount.class} #{foreign_amount} as #{expected}" do
          request.foreign_retailer_transaction_amount = foreign_amount

          expect(rendered_foreign_amount).to eq expected
        end
      end
    end

    describe 'with invalid indicator values' do
      ['f', ' F', 'F ', 'FF', 1, 1.5, BigDecimal('1'), true, false, ['F'], { value: 'F' }].each do |value|
        it "raises with #{value.inspect} without foreign amount" do
          request.foreign_retailer_indicator = value

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /foreign_retailer_indicator/
        end

        it "keeps the reader values after failure with #{value.inspect}" do
          request.foreign_retailer_indicator          = value
          request.foreign_retailer_transaction_amount = '10.50'

          expect([marketplace_build_error&.message.to_s.match?(/foreign_retailer_indicator/),
                  request.foreign_retailer_indicator, request.foreign_retailer_transaction_amount])
            .to eq [true, value, '10.50']
        end
      end

      [['F'], { value: 'F' }].each do |value|
        it "does not mutate the #{value.class} indicator" do
          request.foreign_retailer_indicator = value

          original = value.dup

          expect([marketplace_build_error.class, request.foreign_retailer_indicator.equal?(value), value])
            .to eq [GenesisRuby::ParameterError, true, original]
        end
      end
    end

    describe 'with indicator dependency' do
      [nil, ''].each do |value|
        it "raises with foreign amount and indicator #{value.inspect}" do
          request.foreign_retailer_indicator          = value
          request.foreign_retailer_transaction_amount = '10.50'

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /foreign_retailer_indicator/
        end
      end
    end

    describe 'with invalid foreign amount values' do
      before { request.foreign_retailer_indicator = foreign_retailer }

      [0, '0.00', -1, 'abc', '10,50', true, [], {}, Float::NAN].each do |value|
        it "raises with #{value.inspect}" do
          request.foreign_retailer_transaction_amount = value

          expect { request.build_document }
            .to raise_error GenesisRuby::ParameterError, /foreign_retailer_transaction_amount/
        end

        it "keeps the reader value after failure with #{value.inspect}" do
          request.foreign_retailer_transaction_amount = value

          expect([marketplace_build_error.class, request.foreign_retailer_transaction_amount.equal?(value)])
            .to eq [GenesisRuby::ParameterError, true]
        end
      end
    end

    describe 'with missing required fields' do
      before do
        request.foreign_retailer_indicator          = foreign_retailer
        request.foreign_retailer_transaction_amount = '10.50'
      end

      it 'raises without amount' do
        request.amount = nil

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /required parameter: amount/
      end

      it 'raises without currency' do
        request.currency = nil

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /required parameter: currency/
      end
    end

    describe 'with invalid currency' do
      it 'raises through the generic currency check with a foreign amount set' do
        request.currency                            = 'XYZ'
        request.foreign_retailer_indicator          = foreign_retailer
        request.foreign_retailer_transaction_amount = '10.50'

        expect { request.build_document }
          .to raise_error GenesisRuby::ParameterError, /Parameter currency is set to XYZ/
      end
    end

    describe 'with document shape' do
      let(:marketplace_nodes) { marketplace_xml.xpath('/payment_transaction/marketplace_data') }

      before { request.foreign_retailer_indicator = foreign_retailer }

      it 'renders exactly one marketplace_data under payment_transaction' do
        request.foreign_retailer_transaction_amount = '10.50'

        expect(marketplace_nodes.size).to eq 1
      end

      it 'renders one foreign_retailer_indicator with text F' do
        request.foreign_retailer_transaction_amount = '10.50'
        indicators = marketplace_nodes.xpath('foreign_retailer_indicator')

        expect([indicators.size, indicators.text]).to eq [1, 'F']
      end

      [nil, ''].each do |value|
        it "renders the indicator as the only child with foreign amount #{value.inspect}" do
          request.foreign_retailer_transaction_amount = value

          expect(marketplace_nodes.xpath('*').map(&:name)).to eq %w(foreign_retailer_indicator)
        end
      end

      [[nil, nil], ['', ''], [nil, ''], ['', nil]].each do |indicator, foreign_amount|
        it "does not render marketplace_data with #{indicator.inspect} and #{foreign_amount.inspect}" do
          request.foreign_retailer_indicator          = indicator
          request.foreign_retailer_transaction_amount = foreign_amount

          expect(marketplace_xml.xpath('//marketplace_data')).to be_empty
        end
      end

      it 'renders marketplace_data before funding' do
        request.foreign_retailer_transaction_amount = '10.50'
        request.funding_identifier_type             =
          GenesisRuby::Api::Constants::Transactions::Parameters::Funding::IdentifierTypes.all.first

        expect(marketplace_xml.xpath('/payment_transaction/marketplace_data/following-sibling::funding').size)
          .to eq 1
      end
    end

    describe 'with generated minor-unit amounts' do
      # Feature: f2026082036-add_marketplace_foreign_retailer_data, Property 1: Minor-unit round trip
      # Validates: Requirements 3.3, 3.7, 6.15, 8.14
      it 'round trips the foreign amount through minor units' do # rubocop:disable RSpec/ExampleLength
        money_format = GenesisRuby::Utils::MoneyFormat
        random       = Random.new
        xpath        = '/payment_transaction/marketplace_data/foreign_retailer_transaction_amount'

        aggregate_failures do
          100.times do
            currency       = GenesisRuby::Api::Constants::Currencies::Iso4217.all.sample(random: random).upcase
            a_minor        = random.rand(1..10_000_000)
            # Every fourth iteration on average hits the f_minor == a_minor boundary
            f_minor        = random.rand(4).zero? ? a_minor : random.rand(1..a_minor)
            foreign_amount = money_format.exponent_to_amount(f_minor, currency)
            context        = "currency: #{currency}, a_minor: #{a_minor}, f_minor: #{f_minor}, f: #{foreign_amount}"

            request.currency                            = currency
            request.amount                              = money_format.exponent_to_amount(a_minor, currency)
            request.foreign_retailer_indicator          = foreign_retailer
            request.foreign_retailer_transaction_amount = foreign_amount

            rendered = Nokogiri::XML(request.build_document).xpath(xpath).text

            expect(rendered).to eq(f_minor.to_s), "rendered #{rendered.inspect} for #{context}"
            expect(BigDecimal(money_format.exponent_to_amount(rendered, currency)))
              .to eq(BigDecimal(foreign_amount.to_s)), "round trip mismatch for #{context}"
          end
        end
      end
    end

    describe 'with generated candidate foreign amounts' do
      # Spec-local model predicate, independent of the production code:
      # valid(a, f, c) <=> f finite decimal AND 0 < f AND frac(f * 10^exp(c)) = 0 AND minor(f, c) <= minor(a, c)
      def marketplace_model_valid?(amount, foreign_amount, exponent)
        decimal = BigDecimal(foreign_amount.to_s)
        scale   = 10**exponent

        decimal.finite? && decimal.positive? && (decimal * scale).frac.zero? &&
          (decimal * scale) <= (BigDecimal(amount) * scale)
      end

      # Candidate foreign amount as a BigDecimal drawn from the mixed generator
      def marketplace_candidate(random, a_minor, exponent)
        minor, extra_places = marketplace_candidate_minor(random, a_minor)

        BigDecimal(minor) / BigDecimal(10**(exponent + extra_places))
      end

      # [minor value, extra decimal places]: 1..a_minor (incl. equality), above a_minor, 0, negative, exponent + 1
      def marketplace_candidate_minor(random, a_minor)
        case random.rand(5)
        when 0 then [random.rand(4).zero? ? a_minor : random.rand(1..a_minor), 0]
        when 1 then [a_minor + random.rand(1..1_000), 0]
        when 2 then [0, 0]
        when 3 then [-random.rand(1..a_minor), 0]
        else [(random.rand(1..a_minor) * 10) + random.rand(1..9), 1]
        end
      end

      # Render the decimal as BigDecimal, String, Integer (integral only) or Float (exactly representable only)
      def marketplace_render(random, decimal, exponent)
        case random.rand(4)
        when 0 then decimal
        when 2 then decimal.frac.zero? ? decimal.to_i : decimal.to_s('F')
        when 3 then marketplace_float(decimal, exponent) || decimal.to_s('F')
        else decimal.to_s('F')
        end
      end

      # Float only for exponent <= 2 (at most 3 decimals) when it round trips exactly via to_s
      def marketplace_float(decimal, exponent)
        return nil if exponent > 2

        float = Float(decimal.to_s('F'))

        BigDecimal(float.to_s) == decimal ? float : nil
      end

      # rubocop:disable Layout/LineLength
      # Feature: f2026082036-add_marketplace_foreign_retailer_data, Property 2: Amount validation matches the model predicate
      # rubocop:enable Layout/LineLength
      # Validates: Requirements 6.2, 6.3, 6.4, 6.5, 6.7, 6.8, 8.14
      it 'accepts the foreign amount if and only if the model predicate holds' do # rubocop:disable RSpec/ExampleLength
        money_format = GenesisRuby::Utils::MoneyFormat
        random       = Random.new

        aggregate_failures do
          100.times do
            currency       = GenesisRuby::Api::Constants::Currencies::Iso4217.all.sample(random: random).upcase
            exponent       = GenesisRuby::Api::Constants::Currencies::Iso4217.fetch_exponent(currency)
            a_minor        = random.rand(1..10_000_000)
            amount         = money_format.exponent_to_amount(a_minor, currency)
            foreign_amount = marketplace_render(random, marketplace_candidate(random, a_minor, exponent), exponent)
            expected       = marketplace_model_valid?(amount, foreign_amount, exponent)
            context        = "currency: #{currency}, a: #{amount}, f: #{foreign_amount.inspect} " \
                             "(#{foreign_amount.class}), model: #{expected}"

            request.currency                            = currency
            request.amount                              = amount
            request.foreign_retailer_indicator          = foreign_retailer
            request.foreign_retailer_transaction_amount = foreign_amount

            error = begin
              request.build_document

              nil
            rescue GenesisRuby::ParameterError => e
              e
            end

            expect(error.nil?).to eq(expected), "build_document outcome mismatch (#{error&.message}) for #{context}"
            expect(error&.message || 'foreign_retailer_transaction_amount')
              .to match(/foreign_retailer_transaction_amount/), "unexpected error for #{context}"
            expect(request.foreign_retailer_transaction_amount).to eq(foreign_amount), "reader changed for #{context}"
          end
        end
      end
    end
  end
end

RSpec.shared_examples 'marketplace data subsequent recurring examples' do
  describe 'when subsequent recurring with nil currency and marketplace data' do
    before do
      request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT
      request.currency       = nil
      request.amount         = '50.00'
      request.__send__(:init_field_validations)

      request.foreign_retailer_indicator          =
        GenesisRuby::Api::Constants::Transactions::Parameters::ForeignRetailerIndicators::FOREIGN_RETAILER
      request.foreign_retailer_transaction_amount = '10.50'
    end

    it 'requires only transaction_id and amount' do
      expect(request.__send__(:required_fields)).to eq %i[transaction_id amount]
    end

    it 'raises an error for the foreign retailer transaction amount' do
      expect { request.build_document }
        .to raise_error GenesisRuby::ParameterError, /foreign_retailer_transaction_amount/
    end
  end
end
