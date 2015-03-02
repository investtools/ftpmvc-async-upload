require 'ftpmvc'
require 'ftpmvc/async/upload'
require 'ftpmvc/test_helpers'
require 'resque_spec'

describe 'Async Upload' do
  include FTPMVC::TestHelpers
  before do
    ResqueSpec.reset!
  end
  let(:etc_dir_class) do
    Class.new(FTPMVC::Directory) do
      attr_reader :received
      def put(path, input)
        @received = [path, input.read_all]
      end
    end
  end
  let(:etc_dir) { etc_dir_class.new(name: 'etc') }
  let(:app) do
    dir = etc_dir
    FTPMVC::Application.new do
      filter :async_upload

      filesystem do
        directory dir
      end
    end
  end
  before do
    application = app
    FTPMVC::Async::Upload.configure do
      config.application = application
    end
  end
  it 'delegates the put command to the job' do
    with_resque do
      with_application(app) do |ftp|
        ftp.login
        put(ftp, '/etc/hosts', '127.0.0.1 localhost')
        expect(etc_dir.received).to eq ['hosts', "127.0.0.1 localhost\n"]
      end
    end
  end
  context 'when job is custom' do
    let(:my_job_class) do
      Class.new do
        extend FTPMVC::Async::Upload::Job

        @queue = :ftpmvc

        def self.perform(path, id)
          @result = input(id).read_all
        end

        def self.result
          @result
        end
      end
    end
    before do
      stub_const 'MyJob', my_job_class
      FTPMVC::Async::Upload.configure do
        config.job = MyJob
      end
    end
    it 'uses that job' do
      with_resque do
        with_application(app) do |ftp|
          ftp.login
          put(ftp, '/etc/hosts', '127.0.0.1 localhost')
          expect(MyJob.result).to eq "127.0.0.1 localhost\n"
        end
      end
    end
  end
end