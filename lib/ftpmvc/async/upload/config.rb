require 'tmpdir'
require 'app'

module FTPMVC
  module Async
    module Upload
      class Config < Configurable
        config.dir = Dir.tmpdir
        config.job = nil
      end

      def self.configure(&block)
        config.configure(&block)
      end

      def self.config
        Config
      end

    end
  end
end
