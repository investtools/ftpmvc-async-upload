require 'ftpmvc/async/upload/input'
require 'ftpmvc/async/upload/config'
require 'tmpdir'

describe '#input' do
  around do |example|
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, 'my-file'), 'w') { |f| f.write('content') }
      FTPMVC::Async::Upload.configure do
        config.dir = dir
      end
      example.run
    end
  end
  let(:input) { FTPMVC::Async::Upload::Input.new('my-file') }
  describe '#read' do
    it 'reads the file content chunk-by-chunk' do
      expect { |b| input.read(&b) }.to yield_with_args 'content'
    end
  end
  describe '#read_all' do
    it 'reads all the file content' do
      expect(input.read_all).to eq 'content'
    end
  end
end
