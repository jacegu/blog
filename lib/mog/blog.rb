module Mog
  class Blog
    def initialize(post_repository)
      @post_repository = post_repository
    end

    def list_all_posts
      @post_repository.list_posts
    end

    def list_published_posts
      list_all_posts.select(&:published?).sort_by(&:title).sort(&date_desc)
    end

    private

    def date_desc
      -> (post1, post2) { post2.date <=> post1.date }
    end

  end
end
