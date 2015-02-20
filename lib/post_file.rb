require_relative 'post'
require_relative 'null_post'

class PostFile < Post
  attr_reader :source_file_content

  FIRST_LINE  = 0
  SECOND_LINE = 1
  THIRD_LINE  = 2
  FOURTH_LINE = 3
  FIFTH_LINE  = 4
  LAST_LINE   = -1

  def self.from(file)
    post_file = new(file)
    if post_file.non_empty_lines.empty?
      return NullPost.new
    else
      return post_file
    end
  end

  def initialize(file)
    @source_file_content = file.read
  end

  def language
    non_empty_lines[FIRST_LINE]
  end

  def publication_time
    DateTime.parse(non_empty_lines[SECOND_LINE])
  end

  def title
    non_empty_lines[THIRD_LINE]
  end

  def description
    non_empty_lines[FOURTH_LINE]
  end

  def content
    @source_file_content.split(description).last
    #non_empty_lines[FOURTH_LINE..LAST_LINE].join("\n")
  end

  def non_empty_lines
    lines = @source_file_content.split("\n")
    lines.select{ |l| not l.lstrip.empty? }
  end
end
