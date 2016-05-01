require 'sinatra'
require 'sass'
require_relative '../lib/mog'

class BlogWebsite < Sinatra::Base
  configure do
    set :haml, { :format => :html5 }
  end

  helpers do
    def formatted_post_date_for(post)
      date = Date.parse(post.date)
      "#{Date::ABBR_MONTHNAMES[date.month]} #{date.day}, #{date.year}"
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

  get '/blog/:post_slug' do
    @post = Mog.blog.get_post(params[:post_slug])
    haml :post
  end

  get '/blog/rss' do
    haml :'rss.xml', :layout => false
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
