# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/wpf/reminder_channels'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Wpf::ReminderChannels do

  include_examples 'common constants examples', 'sms'

end
