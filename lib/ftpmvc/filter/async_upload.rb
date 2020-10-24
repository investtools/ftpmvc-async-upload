require 'ftpmvc/async/upload'
require 'ftpmvc/filter/base'
require 'vfs'
require 'sidekiq'

module FTPMVC
  module Filter
    class AsyncUpload < FTPMVC::Filter::Base
      def put(path, input)
        return super if input.is_a?(FTPMVC::Async::Upload::Input)
        SecureRandom.uuid.tap do |id|
          file(id).write do |out|
            input.read { |chunk| out.write(chunk) }
          end
          FTPMVC::Async::Upload.config.job.perform_async(path, id)
        end
      end

      protected

      def file(id)
        FTPMVC::Async::Upload.storage[id]
      end
    end
  end
end
