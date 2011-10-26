#encoding: utf-8

$: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')

require 'sinatra'
require 'sass'
require 'blog'

configure do
  set :haml, { :format => :html5 }
end

before do
  @blog = Blog.new
end

get '/' do
  redirect '/blog'
end

get '/blog' do
  haml :blog
end

get '/blog/:post_url' do
  @post = @blog.published_post_with_url(params[:post_url])
  if @post.found?
    haml :post
  else
    not_found
  end
end

get '/reading' do
  haml :reading
end

get '/about' do
  haml :reading
end

get '/stylesheets/:name.css' do
  sass :"stylesheets/#{params[:name]}"
end

not_found do
  '404'
end