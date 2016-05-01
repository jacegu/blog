module Mog
  class PostRepository
    def initialize(post_dir_path)
      @post_dir_path = File.expand_path(post_dir_path)
    end

    def list_posts
      parse_files(post_files_in(@post_dir_path))
    end

    private

    def post_files_in(post_dir_path)
      Dir.open(post_dir_path)
        .map    { |file| File.join(post_dir_path, file) }
        .reject { |file| File.directory?(file) }
    end

    def parse_files(post_file_paths)
      post_file_paths.map do |file|
        file_to_post(File.read(file))
      end
    end

    def file_to_post(file_content)
      head, body = file_content.split("\n\n---\n\n")
      title, lang, date, description = head.split("\n")

      Post.new(title: title, lang: lang, date: date, description: description, content: body)
    end
  end
end
