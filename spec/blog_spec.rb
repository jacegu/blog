require 'blog'
require 'null_post'

describe Blog do
  let(:post_dir){ double }

  before do
    Blog.stub(:post_dir).and_return(post_dir)
    @blog = Blog.new
  end

  context '::load_posts_from location' do
    it 'assigns the location where the posts will be published from' do
      Blog.load_posts_from post_dir
      Blog.post_dir.should be post_dir
    end
  end

  context '#new' do
    it 'takes the statically configured post dir to load posts from it' do
      @blog.post_dir.should be post_dir
    end
  end

  context 'working with posts' do
    let(:published1) { double(:post, published?: true) }
    let(:published2) { double(:post, published?: true) }
    let(:unpublished){ double(:post, published?: false) }

    before do
      published1.stub(:<=>).with(published2).and_return(1)
      published2.stub(:<=>).with(published1).and_return(-1)
      unpublished.stub(:<=>).and_return(0)
      post_dir.stub_chain(:posts).and_return([unpublished, published2, published1])
    end

    describe '#posts' do
      it 'returns the posts in the directory' do
        @blog.posts.should include(published1, published2, unpublished)
      end
    end

    describe '#published_posts' do
      it 'returns every published post' do
        @blog.published_posts.should include(published1, published2)
      end

      it 'does not return posts that have not been published yet' do
        @blog.published_posts.should_not include(unpublished)
      end

      it 'orders the posts by publication time (newest fist)' do
        @blog.published_posts.should == [published2, published1]
      end
    end

    describe '#each_published_post' do
      it 'yields every published post' do
        yielded_posts = []
        @blog.each_published_post{ |p| yielded_posts << p }
        yielded_posts.should include(published1, published2)
      end
    end

    describe '#published_post_with_url url' do
      let(:the_url) { 'the-post-title-urlified' }

      context 'if a post with the url exists and is published' do
        it 'returns the post' do
          published1.stub(:url).and_return(the_url)
          published2.stub(:url).and_return('another-url')
          @blog.published_post_with_url(the_url).should be(published1)
        end
      end

      context 'if a post with the url exists but is not published' do
        it 'returns a null post' do
          published1.stub(:url).and_return('other-url')
          published2.stub(:url).and_return('another-url')
          unpublished.stub(:url).and_return(the_url)
          @blog.published_post_with_url(the_url).class.should be NullPost
        end
      end

      context 'if no post with given url exists' do
        it 'returns a null post' do
          published1.stub(:url).and_return('other-url')
          published2.stub(:url).and_return('another-url')
          unpublished.stub(:url).and_return('yet-another-url')
          @blog.published_post_with_url(the_url).class.should be NullPost
        end
      end

      context 'if more than a post with given url exists' do
        xit 'do something about it'
      end
    end
  end

end
