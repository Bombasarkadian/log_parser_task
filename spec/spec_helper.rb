# frozen_string_literal: true

require 'deep_cover/builtin_takeover'
require 'simplecov'

DeepCover.configure do
  detect_uncovered %i[case_implicit_else default_argument raise trivial_if]
end

SimpleCov.start

Dir['./lib/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true

  config.order = :random
  Kernel.srand config.seed

  config.add_formatter 'Fuubar'
end
