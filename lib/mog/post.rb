module Mog
  class Post
    attr_reader :title, :lang, :date, :description, :content

    def initialize(title:, lang:, date:, description:, content:)
      @title       = title
      @lang        = lang
      @date        = date
      @description = description
      @content     = content
    end

    def ==(other)
      other.is_a?(Mog::Post) &&
        title == other.title &&
        lang == other.lang &&
        date == other.date &&
        description == other.description &&
        content == other.content
    end
  end
end
