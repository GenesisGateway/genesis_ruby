# frozen_string_literal: true

require 'genesis_ruby/api/constants/date_time_formats'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::DateTimeFormats do

  include_examples 'common constants examples', '%Y-%m-%d'

  it 'when ISO 8601 last element' do
    expect(described_class.all.last).to eq('%Y-%m-%d')
  end

end
