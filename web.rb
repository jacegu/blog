#encoding: utf-8

$: << File.join(File.expand_path(File.dirname(__FILE__)), 'lib')

require 'sinatra'
require 'sass'
require 'blog'

class BlogWebsite < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  helpers do
    def formatted_post_date_for(post)
      date = post.publication_time
      "#{Date::ABBR_MONTHNAMES[date.month]} #{date.day}, #{date.year}"
    end

    def url_for(post)
      url("/blog/#{post.url}")
    end
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

  get '/blog/rss' do
    haml :'rss.xml', :layout => false
  end

  get '/blog/:post_url' do
    @post = @blog.published_post_with_url(params[:post_url])
    if @post.found?
      cache_it_for A_MONTH
      haml :post
    else
      not_found
    end
  end

  get '/reading' do
    haml :reading
  end

  get '/about' do
    haml :about
  end

  get '/stylesheets/:name.css' do
    sass :"stylesheets/#{params[:name]}"
  end

  get '/sitemap.xml' do
    haml :'sitemap.xml', :layout => false
  end

  not_found do
    '404'
  end

  A_MONTH =  60 * 60 * 24 * 30

  def cache_it_for(time)
    cache_control :public, max_age: time
  end
end
