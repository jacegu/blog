require_relative 'publication_time'

class Post
  include Comparable

  attr_reader :title, :description, :content, :publication_time, :language

  def initialize(title, description, content, publication_time, language = 'en')
    @title = title
    @description = description
    @content = content
    @publication_time = publication_time
    @language = language
  end

  def url
    url = title.downcase
    url_chunks = url.split.map{ |chunk| chunk.gsub(/\W|_/, '') }
    url_chunks.join('-')
  end

  def published?
    in_the_past?(publication_time)
  end

  def found?
    true
  end

  def ==(other)
    title == other.title and
      description == other.description and
      content == other.content and
      publication_time == other.publication_time
  end

  def <=>(other)
    other.publication_time <=> publication_time
  end

  private

  def in_the_past?(datetime)
    datetime < DateTime.now
  end
end
