require 'tmpdir'
require 'ftpmvc/filter/async_upload'
require 'ftpmvc/async/upload/job'
require 'ftpmvc/async/upload/config'
require 'ftpmvc/string_input'

class MyAsyncJob < FTPMVC::Async::Upload::DefaultJob
  def perform(_path, id)
    self.class.result = input(id).read_all
  end

  class << self
    attr_writer :result
    attr_reader :result
  end
end

describe FTPMVC::Filter::AsyncUpload do
  let(:storage) { Dir.mktmpdir }
  let(:filter) { FTPMVC::Filter::AsyncUpload.new(nil, nil) }

  around do |example|
    Dir.mktmpdir do |dir|
      FTPMVC::Async::Upload.configure do
        config.dir = dir
        config.job = MyAsyncJob
      end
      example.run
    end
  end
  describe '#put' do
    it 'writes content to storage' do
      id = filter.put('/Documents/password.txt', FTPMVC::StringInput.new('mypassword'))
      expect(File.read(File.join(FTPMVC::Async::Upload::Config.dir, id))).to eq('mypassword')
    end
    it 'enqueues the job' do
      id = filter.put('/Documents/password.txt', FTPMVC::StringInput.new('mypassword'))
      expect(MyAsyncJob).to have_enqueued_sidekiq_job('/Documents/password.txt', id)
      expect(MyAsyncJob).to be_processed_in(:ftpmvc)
    end
  end
end
