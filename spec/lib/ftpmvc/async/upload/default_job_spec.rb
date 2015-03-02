require 'ftpmvc/async/upload/default_job'
require 'ftpmvc/async/upload/config'
require 'ftpmvc/application'
require 'tmpdir'

describe FTPMVC::Async::Upload::DefaultJob do
  let(:etc_dir_class) do
    Class.new(FTPMVC::Directory) do
      attr_reader :received
      def put(path, input)
        @received = [path, input.read_all]
      end
    end
  end
  let(:etc_dir) { etc_dir_class.new(name: 'etc') }
  let(:application) do
    dir = etc_dir
    FTPMVC::Application.new do
      filesystem do
        directory dir
      end
    end
  end
  around do |example|
    Dir.mktmpdir do |dir|
      app = application
      FTPMVC::Async::Upload.configure do
        config.application = app
        config.dir = dir
      end
      File.open(File.join(dir, '123456'), 'w') { |f| f.write '127.0.0.1 localhost' }
      example.run
    end
  end
  describe '.perform' do
    it 'calls Application#put' do

      FTPMVC::Async::Upload::DefaultJob.perform('/etc/hosts', '123456')
      expect(etc_dir.received).to eq ['hosts', '127.0.0.1 localhost']
    end
  end
end
