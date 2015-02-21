require 'blog'
require 'null_post'

describe Blog do
  let(:post_dir){ double }

  before do
    allow(Blog).to receive(:post_dir).and_return(post_dir)
    @blog = Blog.new
  end

  context '::load_posts_from location' do
    it 'assigns the location where the posts will be published from' do
      Blog.load_posts_from post_dir
      expect(Blog.post_dir).to be post_dir
    end
  end

  context '#new' do
    it 'takes the statically configured post dir to load posts from it' do
      expect(@blog.post_dir).to be post_dir
    end
  end

  context 'working with posts' do
    let(:published1) { double('published1', published?: true) }
    let(:published2) { double('published2', published?: true) }
    let(:unpublished){ double('unpublished', published?: false) }

    before do
      allow(published1).to receive(:<=>).with(published2).and_return(1)
      allow(published2).to receive(:<=>).with(published1).and_return(-1)
      allow(published1).to receive(:<=>).with(unpublished).and_return(0)
      allow(published2).to receive(:<=>).with(unpublished).and_return(0)
      allow(unpublished).to receive(:<=>).and_return(0)
      allow(post_dir).to receive_message_chain(:posts).and_return([unpublished, published2, published1])
    end

    describe '#posts' do
      it 'returns the posts in the directory' do
        expect(@blog.posts).to include(published1, published2, unpublished)
      end
    end

    describe '#published_posts' do
      it 'returns every published post' do
        expect(@blog.published_posts).to include(published1, published2)
      end

      it 'does not return posts that have not been published yet' do
        expect(@blog.published_posts).not_to include(unpublished)
      end

      it 'orders the posts by publication time (newest fist)' do
        expect(@blog.published_posts).to eq([published2, published1])
      end
    end

    describe '#each_published_post' do
      it 'yields every published post' do
        yielded_posts = []
        @blog.each_published_post{ |p| yielded_posts << p }
        expect(yielded_posts).to include(published1, published2)
      end
    end

    describe '#published_post_with_url url' do
      let(:the_url) { 'the-post-title-urlified' }

      context 'if a post with the url exists and is published' do
        it 'returns the post' do
          allow(published1).to receive(:url).and_return(the_url)
          allow(published2).to receive(:url).and_return('another-url')
          expect(@blog.published_post_with_url(the_url)).to be(published1)
        end
      end

      context 'if a post with the url exists but is not published' do
        it 'returns a null post' do
          allow(published1).to receive(:url).and_return('other-url')
          allow(published2).to receive(:url).and_return('another-url')
          allow(unpublished).to receive(:url).and_return(the_url)
          expect(@blog.published_post_with_url(the_url).class).to be NullPost
        end
      end

      context 'if no post with given url exists' do
        it 'returns a null post' do
          allow(published1).to receive(:url).and_return('other-url')
          allow(published2).to receive(:url).and_return('another-url')
          allow(unpublished).to receive(:url).and_return('yet-another-url')
          expect(@blog.published_post_with_url(the_url).class).to be NullPost
        end
      end

      context 'if more than a post with given url exists' do
        xit 'do something about it'
      end
    end
  end

end
