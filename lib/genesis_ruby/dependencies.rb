# =================================
# Transaction Request Requirements
# =================================
require 'genesis_ruby/api/mixins/requests/attribute_validation'
require 'genesis_ruby/api/mixins/requests/restricted_setter'
require 'genesis_ruby/api/request'
require 'genesis_ruby/api/mixins/constants/common'

# =================================
# Transaction Requests Definitions
# =================================

# Load API Attributes
Dir["#{File.dirname(__FILE__)}/api/mixins/**/*_attributes.rb"].sort.each { |file| require file }

# =================================
# Transaction Requests Bases
# =================================
require 'genesis_ruby/api/requests/base/financial'
require 'genesis_ruby/api/requests/base/financials/credit_card'
require 'genesis_ruby/api/requests/base/financials/south_american_payments'
require 'genesis_ruby/api/requests/base/reference'
require 'genesis_ruby/api/requests/base/versioned'
require 'genesis_ruby/api/requests/base/consumer'
require 'genesis_ruby/api/requests/financial/sdd/sale'
require 'genesis_ruby/api/requests/base/graphql'
require 'genesis_ruby/api/notification'

# Load Financial and Non Financial API Requests
Dir["#{File.dirname(__FILE__)}/api/requests/*financial/**/*.rb"].sort.each { |file| require file }

# Load WPF API Requests
Dir["#{File.dirname(__FILE__)}/api/requests/wpf/**/*.rb"].sort.each { |file| require file }
