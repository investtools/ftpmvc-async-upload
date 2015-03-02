require 'ftpmvc/async/upload'

describe FTPMVC::Async::Upload::Job do
  let(:file) { File.join(FTPMVC::Async::Upload.config.dir, 'my-file') }
  before do
  end
  around do |example|
    Dir.mktmpdir do |dir|
      FTPMVC::Async::Upload.configure do
        config.dir = dir
      end
      File.open(file, 'w') { |f| f.write('file content') }
      example.run
    end
  end
  let(:job) do
    Class.new do
      extend FTPMVC::Async::Upload::Job

      def self.perform(path, id)
        input(id).read_all
      end
    end
  end
  describe '#after_perform_delete_uploaded_file' do
    it 'deletes the uploaded file' do
      job.after_perform_delete_uploaded_file('/Documents/file.txt', 'my-file')
      expect(File).not_to exist(file)
    end
  end
  describe '#input' do
    it 'is the file input' do
      expect(job.perform('/Documents/file.txt', 'my-file')).to eq 'file content'
    end
  end
end
