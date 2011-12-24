class Blog
  attr_reader :post_dir

  def self.load_posts_from(post_dir)
    @@post_dir = post_dir
  end

  def self.post_dir
    @@post_dir
  end

  def initialize
    @post_dir = Blog.post_dir
  end

  def posts
    @post_dir.posts.sort
  end

  def published_posts
    posts.select{ |p| p.published? }
  end

  def each_published_post
    published_posts.each { |p| yield p }
  end

  def published_post_with_url(url)
    if post = published_posts.select{ |p| p.url == url }.first
      return post
    else
      return NullPost.new
    end
  end
end
