require 'vfs'
require 'ftpmvc/async/upload/version'
require 'ftpmvc/async/upload/config'
require 'ftpmvc/async/upload/job'
require 'ftpmvc/async/upload/default_job'
require 'ftpmvc/filter/async_upload'

module FTPMVC
  module Async
    module Upload
      def self.storage
        FTPMVC::Async::Upload.config.dir.to_dir
      end
    end
  end
end
