# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/restricted_setter_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::RestrictedSetter do
  let(:restricted_setter) { GenesisSpec::Stubs::Api::Requests::RestrictedSetterStub.new }

  describe 'when allowed options' do
    let(:allowed_values) { [1, 2] }
    let(:attribute) { 'attr_option' }

    it 'with allowed value' do
      expect(
        restricted_setter.__send__(:allowed_options, attribute: attribute, allowed: allowed_values, value: 1)
      ).to eq 1
    end

    it 'with assigned instance variable' do
      expect(
        restricted_setter.__send__(:allowed_options, attribute: attribute, allowed: allowed_values, value: 1)
      ).to eq restricted_setter.attr_option
    end

    it 'without allowed empty' do
      expect do
        restricted_setter.__send__(:allowed_options, attribute: attribute, allowed: allowed_values, value: '')
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with allowed empty' do
      restricted_setter.__send__(
        :allowed_options, attribute: attribute, allowed: allowed_values, value: '', allow_empty: true
      )

      expect(restricted_setter.attr_option).to eq nil
    end

  end

  describe 'when limited string' do
    let(:attribute) { 'attr_string' }

    it 'without min and max' do
      expect(restricted_setter.__send__(:limited_string, attribute: attribute, value: 'string')).to eq 'string'
    end

    it 'with max when invalid value length' do
      expect do
        restricted_setter.__send__ :limited_string, attribute: attribute, value: 'string', max: 2
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with max when valid value length' do
      expect(restricted_setter.__send__(:limited_string, attribute: attribute, value: 'st', max: 2)).to eq 'st'
    end

    it 'with empty value when min nil' do
      expect(restricted_setter.__send__(:limited_string, attribute: attribute, value: '', max: 2)).to eq ''
    end

    it 'with min when valid value length' do
      expect(restricted_setter.__send__(:limited_string, attribute: attribute, value: 'st', min: 1)).to eq 'st'
    end

    it 'with min when invalid value length' do
      expect do
        restricted_setter.__send__(:limited_string, attribute: attribute, value: 's', min: 2)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with assigned instance variable' do
      restricted_setter.__send__ :limited_string, attribute: attribute, value: 'string', min: 1, max: 6

      expect(restricted_setter.attr_string).to eq 'string'
    end
  end

  describe 'when parse date' do
    let(:attribute) { 'attr_date' }
    let(:fake_date) { Faker::Date.in_date_period }

    it 'with allowed format' do
      expect(
        restricted_setter.__send__(:parse_date, attribute: attribute, value: fake_date.strftime('%Y-%m-%d'))
      ).to be_kind_of Date
    end

    it 'without allowed format' do
      expect do
        restricted_setter.__send__ :parse_date, attribute: attribute, value: fake_date.strftime('%Y:%m:%d')
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'assign instance variable' do
      restricted_setter.__send__(:parse_date, attribute: attribute, value: fake_date.strftime('%Y-%m-%d'))

      expect(restricted_setter.attr_date).to be_kind_of Date
    end

    it 'without allowed empty' do
      expect do
        restricted_setter.__send__ :parse_date, attribute: attribute, value: ''
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with allowed empty' do
      restricted_setter.__send__ :parse_date, attribute: attribute, value: '', allow_empty: true

      expect(restricted_setter.attr_date).to eq nil
    end
  end

  describe 'when parse int' do
    let(:attribute) { 'attr_int' }
    let(:number) { Faker::Number.number }

    it 'with integer value' do
      expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: number)).to eq number
    end

    it 'with string value' do
      expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: number.to_s)).to eq number
    end

    it 'with mixed string value when starts with number' do
      expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: "#{number}string")).to eq number
    end

    it 'with mixed string value when starts with string' do
      expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: "string#{number}")).to eq 0
    end

    describe 'without allow empty' do
      it 'with nil value' do
        expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: nil)).to eq 0
      end

      it 'with empty value' do
        expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: '')).to eq 0
      end
    end

    describe 'with allow empty' do
      it 'with nil value' do
        expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: nil, allow_empty: true)).to eq nil
      end

      it 'with empty value' do
        expect(restricted_setter.__send__(:parse_int, attribute: attribute, value: '', allow_empty: true)).to eq nil
      end
    end

    describe 'when assigned instance variable' do
      it 'with string number value' do
        restricted_setter.__send__ :parse_int, attribute: attribute, value: number.to_s

        expect(restricted_setter.attr_int).to eq number
      end

      it 'with float number value' do
        restricted_setter.__send__ :parse_int, attribute: attribute, value: '0.99'

        expect(restricted_setter.attr_int).to eq 0
      end

      it 'with allow empty when nil value' do
        restricted_setter.__send__ :parse_int, attribute: attribute, value: nil, allow_empty: true

        expect(restricted_setter.attr_int).to eq nil
      end

      it 'with allow empty when empty value' do
        restricted_setter.__send__ :parse_int, attribute: attribute, value: '', allow_empty: true

        expect(restricted_setter.attr_int).to eq nil
      end
    end
  end

  describe 'when parse_array_of_strings' do
    let(:attribute) { 'attr_arr' }
    let(:allowed) { %w(value1 value2 value3) }
    let(:value) { %w(value1) }

    it 'with invalid non-array value' do
      expect { restricted_setter.__send__ :parse_array_of_strings, attribute: attribute, value: Faker::Lorem.word }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with every allowed value' do
      value = [Faker::Lorem.word]

      expect(restricted_setter.__send__(:parse_array_of_strings, attribute: attribute, value: value, allowed: []))
        .to eq value
    end

    it 'when empty value without allowed_empty' do
      value = []

      expect do
        restricted_setter
          .__send__(:parse_array_of_strings, attribute: attribute, value: value, allowed: [], allow_empty: false)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'when empty value with allowed_empty' do
      value = []

      expect(restricted_setter
               .__send__(:parse_array_of_strings, attribute: attribute, value: value, allowed: [], allow_empty: true))
        .to eq []
    end

    it 'when assigned instance variable' do
      restricted_setter.__send__ :parse_array_of_strings, attribute: attribute, value: value, allowed: []

      restricted_setter.attr_arr = value
    end

    describe 'when allowed values' do
      it 'when valid value' do
        expect(
          restricted_setter.__send__(:parse_array_of_strings, attribute: attribute, value: value, allowed: allowed)
        ).to eq value
      end

      it 'when invalid value' do
        value = [Faker::Lorem.word]

        expect do
          restricted_setter.__send__ :parse_array_of_strings, attribute: attribute, value: value, allowed: allowed
        end.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'when empty value with allowed_empty' do
        expect(
          restricted_setter.__send__(
            :parse_array_of_strings, attribute: attribute, value: [], allowed: allowed, allow_empty: true
          )
        ).to eq []
      end

      it 'when empty value without allowed_empty' do
        expect do
          restricted_setter.__send__(
            :parse_array_of_strings, attribute: attribute, value: [], allowed: allowed, allow_empty: false
          )
        end.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'when valid values with limited allowed value' do
        values = value.push 'value2'

        expect(
          restricted_setter.__send__(:parse_array_of_strings, attribute: attribute, value: values, allowed: allowed)
        ).to eq values
      end
    end
  end

  describe 'when parse_email' do
    let(:attribute) { 'attr_email' }
    let(:valid_email) { 'test@example.com' }

    it 'with valid email address' do
      expect(
        restricted_setter.__send__(:parse_email, attribute: attribute, value: valid_email)
      ).to eq valid_email
    end

    it 'with invalid email address' do
      expect do
        restricted_setter.__send__(:parse_email, attribute: attribute, value: 'invalid-email')
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'without allowed empty' do
      expect do
        restricted_setter.__send__(:parse_email, attribute: attribute, value: '')
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with allowed empty' do
      expect(restricted_setter.__send__(:parse_email, attribute: attribute, value: '', allow_empty: true)).to eq nil
    end

    it 'with email containing subdomains' do
      email = 'test@sub.example.com'
      expect(
        restricted_setter.__send__(:parse_email, attribute: attribute, value: email)
      ).to eq email
    end

    it 'with email containing plus sign' do
      email = 'test+label@example.com'
      expect(
        restricted_setter.__send__(:parse_email, attribute: attribute, value: email)
      ).to eq email
    end

    it 'with nil value and allow_empty true' do
      expect(restricted_setter.__send__(:parse_email, attribute: attribute, value: nil, allow_empty: true)).to eq nil
    end
  end
end
