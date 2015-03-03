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
        Vfs::Entry.new(FTPMVC::Async::Upload.config.driver, FTPMVC::Async::Upload.config.dir).dir
      end
    end
  end
end
