# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# will_paginationの日本語化
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '&larr;'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '&rarr;'