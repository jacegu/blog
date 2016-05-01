module Mog
  class Blog
    def initialize(post_repository)
      @post_repository = post_repository
    end

    def get_post(post_slug)
      list_published_posts.find(&by_slug(post_slug)) or raise Errors::PostNotFound
    end

    def list_published_posts
      list_all_posts.select(&:published?).sort_by(&:title).sort(&by_date_desc)
    end

    def list_all_posts
      @post_repository.list_posts
    end

    private

    def by_slug(slug)
      -> (post) { post.slug == slug }
    end

    def by_date_desc
      -> (post1, post2) { post2.date <=> post1.date }
    end

  end
end
