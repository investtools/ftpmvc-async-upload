require 'ftpmvc/async/upload'
require 'ftpmvc/input'

module FTPMVC
  module Async
    module Upload
      class Input

        include FTPMVC::Input

        def initialize(id)
          @file = FTPMVC::Async::Upload.storage[id]
        end

        def read
          @file.read { |chunk| yield chunk }
        end
      end
    end
  end
end
