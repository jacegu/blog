require "./web/site"

require "compass"
require "sprockets"
require "sprockets-sass"
require "susy"

BlogWebsite.configure(:production) do
  Sprockets::Sass.options[:style] = :compressed
  Sprockets::Sass.options[:line_comments] = false
end

Compass.configuration do |config|
  config.project_path = File.join(File.dirname(__FILE__), "web")
  config.sass_dir = "web/assets/stylesheets/"
end

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path "web/assets/javascripts"
  environment.append_path "web/assets/stylesheets"
  run environment
end

map '/' do
  run BlogWebsite
end
