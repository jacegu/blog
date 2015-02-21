require 'post_dir'

describe PostDir do
  let(:dir) { double :opened_directory }
  let(:path){ '/path/to/the/directory' }

  before do
    allow(dir).to receive(:path).and_return(path)
  end

  it 'has a path' do
    expect(PostDir.new(dir).path).to eq(path)
  end

  describe '::from directory' do
    it 'creates a post directory from the opened directory' do
      expect(PostDir).to receive(:new).with(dir)
      PostDir.from(dir)
    end
  end

  describe '::at path' do
    it 'opens the directory at the given path' do
      expect(Dir).to receive(:open).with(path)
      PostDir.at(path)
    end

    it 'creates a post directory with the opened directory' do
      the_post_dir = double :post_dir
      allow(Dir).to receive(:open).with(path).and_return(dir)
      expect(PostDir).to receive(:new).with(dir).and_return(the_post_dir)
      expect(PostDir.at(path)).to eq(the_post_dir)
    end
  end

  context 'working with its content' do
    let(:a_file_entry)            { 'not_a_post.html' }
    let(:path_to_file_entry)      { File.join(path, a_file_entry) }
    let(:a_post_file_entry)       { 'post-file.post' }
    let(:path_to_post_file_entry) { File.join(path, a_post_file_entry) }
    let(:a_dir_entry)             { 'dir_named_like_a.post' }
    let(:path_to_dir_entry)       { File.join(path, a_dir_entry) }

    before do
      allow(File).to receive(:file?).with(path_to_file_entry).and_return(true)
      allow(File).to receive(:file?).with(path_to_post_file_entry).and_return(true)
      allow(File).to receive(:file?).with(path_to_dir_entry).and_return(false)
      allow(dir).to receive(:entries).and_return([a_post_file_entry, a_dir_entry, a_file_entry])
      @dir = PostDir.from(dir)
    end

    describe '#entries' do
      it 'returns the absolute path of the entries of the directory' do
        expect(@dir.entries).to include(path_to_file_entry,
                                    path_to_post_file_entry,
                                    path_to_dir_entry)
      end
    end

    describe '#post_file_entries' do
      it 'returns the entries named like a post' do
        expect(@dir.post_file_entries).to include(path_to_post_file_entry)
      end

      it 'only returns entries that are files (ignores dirs)' do
        expect(@dir.post_file_entries).not_to include(path_to_dir_entry)
      end
    end

    describe '#posts' do
      let(:the_file)      { double(:file) }
      let(:the_post_file) { double(:post_file) }

      before do
        allow(File).to receive(:open).with(path_to_post_file_entry).and_return(the_file)
        allow(PostFile).to receive(:from).with(the_file).and_return(the_post_file)
      end

      it 'returns a post for each post file in it' do
        expect(@dir.posts).to eq([the_post_file])
      end

      it 'does not create posts from directories' do
        expect(File).not_to receive(:open).with(path_to_dir_entry)
        @dir.posts
      end

      it 'does not create posts from files that are not posts' do
        expect(File).not_to receive(:open).with(path_to_file_entry)
        @dir.posts
      end
    end
  end
end
