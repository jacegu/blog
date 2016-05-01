module Mog
  class Post
    attr_reader :title, :lang, :date, :description, :content

    def initialize(title: "", lang: "", date: "", description: "", content: "")
      @title       = title
      @lang        = lang
      @date        = date
      @description = description
      @content     = content
    end

    def slug
      @slug ||= generate_slug
    end

    def published?
      Date.today >= Date.parse(date)
    end

    def ==(other)
      other.is_a?(Mog::Post) &&
        title == other.title &&
        lang == other.lang &&
        date == other.date &&
        description == other.description &&
        content == other.content
    end

    private

    def generate_slug
      slug = title.downcase
      slug_chunks = slug.split.map{ |chunk| chunk.gsub(/\W|_/, '') }
      slug_chunks.join('-')
    end
  end
end
