require_relative 'mog/blog'
require_relative 'mog/post'
require_relative 'mog/post_repository'

module Mog

  def self.blog(post_repository: self.post_repository)
    Blog.new(post_repository)
  end

  def self.post_repository(post_dir_path: "_posts")
    PostRepository.new(post_dir_path)
  end

end
