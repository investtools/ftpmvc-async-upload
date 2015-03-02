require 'ftpmvc/async/upload/job'
require 'ftpmvc/async/upload/config'

module FTPMVC
  module Async
    module Upload
      class DefaultJob
        @queue = :ftpmvc
        
        extend Job

        def self.perform(path, id)
          FTPMVC::Async::Upload.config.application.put(path, input(id))
        end
      end
    end
  end
end

FTPMVC::Async::Upload.configure do
  config.job = config.job || FTPMVC::Async::Upload::DefaultJob
end
