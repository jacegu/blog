require 'date'

module Mog
  class Post
    attr_reader :title, :lang, :date, :description, :content, :permalink

    def initialize(title: "", lang: "", date: nil, description: "", content: "")
      @title       = title
      @lang        = lang
      @date        = to_date(date)
      @description = description
      @content     = content
      @permalink   = generate_permalink(title)
    end

    def published?
      Date.today >= date
    end

    def ==(other)
      other.is_a?(Mog::Post) && title == other.title
    end

    private

    def to_date(date)
      case date
      when NilClass then nil
      when Date     then date
      when String   then Date.parse(date)
      end
    end

    def generate_permalink(text)
      permalink_chunks = text.downcase.split.map { |chunk| chunk.gsub(/\W|_/, '') }
      permalink_chunks.join('-')
    end

  end
end
