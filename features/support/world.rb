require 'tmpdir'

module PostHandling
  TEMPORAL_DIR = Dir.tmpdir

  SAMPLE_PUBLICATION_DATE = '2011-01-01 10:00:00+02:00'
  SAMPLE_TITLE            = 'title'
  SAMPLE_DESCRIPTION      = 'description'
  SAMPLE_CONTENT          = 'content'

  def create_post_file_with(content)
    file_name = 'cucumber_post.post'
    @file_path = File.join(TEMPORAL_DIR, file_name)
    File.open(@file_path, 'w+'){ |f| f.puts content }
  end

  def a_post_file_with(date, title, description, content)
    "#{date}\n#{title}\n#{description}\n#{content}"
  end
end

World(PostHandling)
