# =================================
# Transaction Request Requirements
# =================================
require 'genesis_ruby/api/request'
require 'genesis_ruby/api/mixins/constants/common'
require 'genesis_ruby/api/mixins/requests/restricted_setter'

# =================================
# Transaction Requests Definitions
# =================================

# Load API Attributes
Dir["#{File.dirname(__FILE__)}/api/mixins/**/*_attributes.rb"].sort.each { |file| require file }

# Load Financial and Non Financial API Requests
Dir["#{File.dirname(__FILE__)}/api/requests/*financial/**/*.rb"].sort.each { |file| require file }

# Load WPF API Requests
Dir["#{File.dirname(__FILE__)}/api/requests/wpf/**/*.rb"].sort.each { |file| require file }
