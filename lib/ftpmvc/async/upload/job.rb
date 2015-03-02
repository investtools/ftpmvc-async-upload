require 'ftpmvc/async/upload'
require 'ftpmvc/async/upload/input'

module FTPMVC
  module Async
    module Upload
      module Job
        def after_perform_delete_uploaded_file(path, id)
          FTPMVC::Async::Upload.storage[id].delete
        end

        protected

        def input(id)
          FTPMVC::Async::Upload::Input.new(id)
        end
      end
    end
  end
end
