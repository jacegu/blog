require_relative 'post'

class NullPost < Post
  PUBLICATION_TIME = DateTime.parse('99999-12-31 23:59:59+00:00')

  def initialize
    @title, @description, @content = '', '', ''
    @publication_time = PUBLICATION_TIME
  end

  def found?
    false
  end
end
