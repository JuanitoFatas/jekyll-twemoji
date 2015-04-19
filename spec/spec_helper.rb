$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "jekyll/twemoji"

RSpec.configure do |config|
  FIXTURES_DIR = File.expand_path("../fixture_site", __FILE__)

  def fixtures_dir(*paths)
    File.join(FIXTURES_DIR, *paths)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
  Kernel.srand config.seed
end
