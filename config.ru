require './web'
require './lib/post_dir'

Blog.load_posts_from PostDir.at('_posts')

run Sinatra::Application
