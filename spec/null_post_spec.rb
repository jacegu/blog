require 'null_post'

describe NullPost do
  let(:null_post){ NullPost.new }

  it 'has an empty title' do
    null_post.title.should be_empty
  end

  it 'has an empty description' do
    null_post.description.should be_empty
  end

  it 'has an empty content' do
    null_post.content.should be_empty
  end

  it 'has 99999-12-31 23:59:59+00:00 as publication time' do
    expected_time = DateTime.parse('99999-12-31 23:59:59+00:00')
    null_post.publication_time.should == expected_time
  end

  it 'has an empty url' do
    null_post.url.should be_empty
  end

  it 'has an empty language' do
    null_post.language.should be_empty
  end

  it 'is never published' do
    null_post.should_not be_published
  end

  it 'is never found' do
    null_post.should_not be_found
  end
end
