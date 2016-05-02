require 'sinatra'
require 'sass'
require 'redcarpet'
require_relative '../lib/mog'

class BlogWebsite < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  helpers do
    def formatted_post_date_for(post)
      "#{Date::ABBR_MONTHNAMES[post.date.month]} #{post.date.day}, #{post.date.year}"
    end

    RFC822_FORMAT = "%a, %d %b %Y %T %z"
    def date_to_rfc822(post)
      post.date.strftime(RFC822_FORMAT)
    end

    def url_for(post)
      url("/blog/#{post.slug}")
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
    haml :'rss.xml', layout: false
  end

  get '/blog/:post_slug' do
    @post = Mog.blog.get_post(params[:post_slug])
    haml :post
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

  error Mog::Errors::PostNotFound do
    not_found
  end

  not_found do
    "404"
  end

end
