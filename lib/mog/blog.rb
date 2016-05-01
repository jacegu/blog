module Mog
  class Blog
    def initialize(post_repository)
      @post_repository = post_repository
    end

    def list_posts
      @post_repository.list_posts
    end
  end
end
