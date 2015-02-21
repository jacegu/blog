require 'post_file'

describe PostFile do
  let(:language) { 'es' }
  let(:publication_time){ DateTime.parse('2011-01-01 12:00:00+00:00') }
  let(:the_file_content){ "es\n\n#{publication_time}\ntitle\n  \ndescription\nfirst content line\n  \nsecond content line" }

  before(:each) do
    the_file = double(:file)
    allow(the_file).to receive(:read).and_return(the_file_content)
    @post_file = PostFile.new(the_file)
  end

  describe '::from' do
    let(:the_file){ double(:file) }

    context 'if the file is empty' do
      it 'returns a NullPost' do
        allow(the_file).to receive(:read).and_return('')
        expect(PostFile.from(the_file).class).to eq(NullPost)
      end
    end

    context 'if the file is not empty' do
      it 'returns a post file' do
        allow(the_file).to receive(:read).and_return(the_file_content)
        expect(PostFile.from(the_file).class).to eq(PostFile)
      end
    end
  end

  describe '#new' do
    it 'reads the content of the given file' do
      expect(@post_file.source_file_content).to eq(the_file_content)
    end
  end

  describe '#language' do
    it 'returns the first line of the file content' do
      expect(@post_file.language).to eq(language)
    end
  end

  describe '#publication_time' do
    it 'returns the second line with text of the file content' do
      expect(@post_file.publication_time).to eq(publication_time)
    end
  end

  describe '#title' do
    it 'returns the third line with text of the file content' do
      expect(@post_file.title).to eq('title')
    end
  end

  describe '#description' do
    it 'returns the fourth line with text of the file content' do
      expect(@post_file.description).to eq('description')
    end
  end

  describe '#content' do
    it 'returns every line from the fith to the last' do
      expect(@post_file.content).to eq("\nfirst content line\n  \nsecond content line")
    end
  end

  it 'is equal to a post with the same title, description, content, publication time and language' do
    the_post = Post.new('title',
                        'description',
                        "\nfirst content line\n  \nsecond content line",
                        publication_time,
                       'es')
    expect(@post_file).to eq(the_post)
    expect(the_post).to eq(@post_file)
  end
end
