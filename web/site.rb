require 'sinatra'
require 'haml'
require 'sass'
require 'maruku'
require_relative '../lib/mog'

class BlogWebsite < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  helpers do
    def formatted_post_date_for(post)
      "#{Date::ABBR_MONTHNAMES[post.date.month]} #{post.date.day}, #{post.date.year}"
    end

    def date_to_rfc822(post)
      post.date.strftime("%a, %d %b %Y %T %z")
    end

    def url_for(post)
      url("/blog/#{post.permalink}")
    end
  end


  get '/' do
    haml :home
  end

  get '/blog' do
    @posts = Mog.blog.list_published_posts
    haml :blog
  end

  get '/blog/rss' do
    @posts = Mog.blog.list_published_posts
    content_type "application/rss+xml", charset: "utf-8"
    haml :'rss.xml', layout: false
  end

  get '/blog/:post_permalink' do
    @post = Mog.blog.get_post(params[:post_permalink])
    haml :post
  end

  get '/about' do
    haml :about
  end

  get '/stylesheets/:name.css' do
    sass :"stylesheets/#{params[:name]}"
  end

  get '/sitemap.xml' do
    content_type "application/xml", charset: "utf-8"
    haml :'sitemap.xml', :layout => false
  end

  error Mog::Errors::PostNotFound do
    not_found
  end

  not_found do
    "404"
  end

end
