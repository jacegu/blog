#encoding: utf-8
require 'post'

def a_post_entitled(title)
  Post.new(title, 'description', 'content', DateTime.new, 'en')
end

def a_post_described_as(description)
  Post.new('title', description, 'content', DateTime.new, 'en')
end

def a_post_with_content(content)
  Post.new('title', 'description', content, DateTime.new, 'en')
end

def a_post_published_on(publication_time)
  Post.new('title', 'description', 'content', DateTime.parse(publication_time), 'en')
end

describe Post do
  describe '#new' do
    let(:title)            { 'the post title' }
    let(:description)      { 'the post description' }
    let(:content)          { 'the post content' }
    let(:publication_time) { DateTime.new }
    let(:language)         { 'en' }

    before do
      @post = Post.new(title, description, content, publication_time, language)
    end

    it 'is created with a title' do
      expect(@post.title).to eq(title)
    end

    it 'is created with a description' do
      expect(@post.description).to eq(description)
    end

    it 'is created with a content' do
      expect(@post.content).to eq(content)
    end

    it 'is created with a publication time' do
      expect(@post.publication_time).to eq(publication_time)
    end

    it 'is created with a language' do
      expect(@post.language).to eq(language)
    end
  end

  describe '#url' do
    it 'returns the post title in lowercase' do
      post = a_post_entitled('TiTLe')
      expect(post.url).to eq('title')
    end

    it 'replaces the spaces in the title with "-"' do
      post = a_post_entitled('a title with spaces')
      expect(post.url).to eq('a-title-with-spaces')
    end

    it 'replaces tabs in the title with "-"' do
      post = a_post_entitled('a title with tabs')
      expect(post.url).to eq('a-title-with-tabs')
    end

    it 'removes non alphanumeric characters' do
      post = a_post_entitled('&t.h·3,/ "p¡0!s(t) -[/t$1%t&l3?')
      expect(post.url).to eq('th3-p0st-t1tl3')
    end

    it 'removes underscores "_"' do
      post = a_post_entitled('a_ title_ with_ underscores_')
      expect(post.url).to eq('a-title-with-underscores')
    end
  end

  describe '#published?' do
    it 'is true if the publication time is past' do
      post = a_post_published_on('2011-01-01 10:00:00+00:00')
      expect(post).to be_published
    end

    it 'is false otherwise' do
      post = a_post_published_on('99999-12-31 23:59:59+00:00')
      expect(post).not_to be_published
    end
  end

  describe 'two posts' do
    it 'are equal with the same title, description, content, publication time and language' do
      a_date = DateTime.parse('2011-01-01 10:00:00+00:00')
      a_post       = Post.new('t', 'd', 'c', a_date, 'en')
      another_post = Post.new('t', 'd', 'c', a_date, 'en')
      expect(a_post).to eq(another_post)
      expect(another_post).to eq(a_post)
    end

    it 'are different with different titles' do
      a_post       = a_post_entitled('a')
      another_post = a_post_entitled('b')
      expect(a_post).not_to eq(another_post)
      expect(another_post).not_to eq(a_post)
    end

    it 'are different with different descriptions' do
      a_post       = a_post_described_as('a')
      another_post = a_post_described_as('b')
      expect(a_post).not_to eq(another_post)
      expect(another_post).not_to eq(a_post)
    end

    it 'are different with different content' do
      a_post       = a_post_with_content('a')
      another_post = a_post_with_content('b')
      expect(a_post).not_to eq(another_post)
      expect(another_post).not_to eq(a_post)
    end

    it 'are different with different publication time' do
      a_post       = a_post_published_on('2011-01-01')
      another_post = a_post_published_on('1999-12-12')
      expect(a_post).not_to eq(another_post)
      expect(another_post).not_to eq(a_post)
    end
  end

  describe '#<=>' do
    it 'compares posts based on their publication time (older is bigger)' do
      first_post  = a_post_published_on('2011-01-01 00:00:00+00:00')
      second_post = a_post_published_on('2011-01-01 00:00:01+00:00')
      expect(first_post).to be > second_post
    end
  end

  describe '#found?' do
    it 'is always found (true)' do
      expect(a_post_entitled('title')).to be_found
    end
  end
end
