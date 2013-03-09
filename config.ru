require './web'
require './lib/post_dir'

require 'compass'
require 'sprockets'
require 'sprockets-sass'
require 'susy'

Blog.load_posts_from PostDir.at('_posts')

BlogWebsite.configure(:production) do
  Sprockets::Sass.options[:style] = :compressed
  Sprockets::Sass.options[:line_comments] = false
end

Compass.configuration do |config|
  config.project_path = File.dirname(__FILE__)
  config.sass_dir = 'assets/stylesheets/'
end

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  run environment
end

map '/' do
  run BlogWebsite
end
