require 'spec_helper'
require 'post_file'

describe PostFile do
  let(:publication_time){ DateTime.parse('2011-01-01 12:00:00+00:00') }
  let(:the_file_content){ "#{publication_time}\ntitle\n  \ndescription\nfirst content line\n  \nsecond content line" }

  before(:each) do
    the_file = stub(:file)
    the_file.stub(:read).and_return(the_file_content)
    @post_file = PostFile.new(the_file)
  end

  describe '::from' do
    let(:the_file){ double(:file) }

    context 'if the file is empty' do
      it 'returns a NullPost' do
        the_file.stub(:read).and_return('')
        PostFile.from(the_file).class.should == NullPost
      end
    end

    context 'if the file is not empty' do
      it 'returns a post file' do
        the_file.stub(:read).and_return(the_file_content)
        PostFile.from(the_file).class.should == PostFile
      end
    end
  end

  describe '#new' do
    it 'reads the content of the given file' do
      @post_file.source_file_content.should == the_file_content
    end
  end

  describe '#publication_time' do
    it 'returns the first line with text of the file content' do
      @post_file.publication_time.should == publication_time
    end
  end

  describe '#title' do
    it 'returns the second line with text of the file content' do
      @post_file.title.should == 'title'
    end
  end

  describe '#description' do
    it 'returns the third line with text of the file content' do
      @post_file.description.should == 'description'
    end
  end

  describe '#content' do
    it 'returns every line from the fourth to the last' do
      @post_file.content.should == "first content line\nsecond content line"
    end
  end

  it 'is equal to a post with the same title, description, content and publication time' do
    the_post = Post.new('title',
                        'description',
                        "first content line\nsecond content line",
                        publication_time)
    @post_file.should == the_post
    the_post.should == @post_file
  end
end
