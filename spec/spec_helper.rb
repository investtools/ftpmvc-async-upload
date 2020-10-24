if ENV.include?('CODECLIMATE_REPO_TOKEN')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'ftpmvc/test_helpers'
require 'rspec-sidekiq'
require 'sidekiq/testing/inline'
require 'sidekiq-status/testing/inline'
require 'pry'
Sidekiq::Testing.fake!

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true

  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end

RSpec.configure do |config|
  config.include FTPMVC::TestHelpers
end
