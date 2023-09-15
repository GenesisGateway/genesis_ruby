require 'genesis_ruby/utils/options/base'

RSpec.describe GenesisRuby::Utils::Options::Base do
  let(:options) { described_class.new }

  include_examples 'option examples'
end
