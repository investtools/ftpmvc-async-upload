require 'tmpdir'
require 'ftpmvc/filter/async_upload'
require 'ftpmvc/async/upload/job'
require 'ftpmvc/async/upload/config'
require 'ftpmvc/string_input'

describe FTPMVC::Filter::AsyncUpload do
  let(:storage) { Dir.mktmpdir }
  let(:filter) { FTPMVC::Filter::AsyncUpload.new(nil, nil) }
  let(:job_class) { Class.new { @queue = :ftpmvc } }
  around do |example|
    job = job_class
    Dir.mktmpdir do |dir|
      FTPMVC::Async::Upload.configure do
        config.dir = dir
        config.job = job
      end
      example.run
    end
  end
  describe '#put' do
    it 'writes content to storage' do
      id = filter.put('/Documents/password.txt', FTPMVC::StringInput.new('mypassword'))
      expect(File.read(File.join(FTPMVC::Async::Upload::Config.dir, id))).to eq 'mypassword'
    end
    it 'enqueues the job' do
      id = filter.put('/Documents/password.txt', FTPMVC::StringInput.new('mypassword'))
      expect(job_class).to have_queued('/Documents/password.txt', id).in(:ftpmvc)
    end
  end
end
