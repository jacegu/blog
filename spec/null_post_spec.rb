require 'null_post'

describe NullPost do
  let(:null_post){ NullPost.new }

  it 'has an empty title' do
    expect(null_post.title).to be_empty
  end

  it 'has an empty description' do
    expect(null_post.description).to be_empty
  end

  it 'has an empty content' do
    expect(null_post.content).to be_empty
  end

  it 'has 99999-12-31 23:59:59+00:00 as publication time' do
    expected_time = DateTime.parse('99999-12-31 23:59:59+00:00')
    expect(null_post.publication_time).to eq(expected_time)
  end

  it 'has an empty url' do
    expect(null_post.url).to be_empty
  end

  it 'has an empty language' do
    expect(null_post.language).to be_empty
  end

  it 'is never published' do
    expect(null_post).not_to be_published
  end

  it 'is never found' do
    expect(null_post).not_to be_found
  end
end
