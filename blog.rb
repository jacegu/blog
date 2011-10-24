require 'sinatra'
require 'sass'

configure do
  set :haml, { :format => :html5 }
end

get '/' do
  haml :index
end

get '/blog' do
  @title = "Javier Acero's blog"
  @description = 'Where I record the things I learn and share them with you. This is also the place where I keep my long road logbook.'
  haml :blog
end

get '/post' do
  @title = "Javier Acero's blog - Pedigree vs Awesomeness"
  @description = 'Tom Preston-Werner gave the best definiton of what University is to professionals in the programming field during his interview on the Teach me to code podcast.'
  haml :post
end

get '/reading' do
  @description = "What I'm reading, the books I have read and the ones I want to read"
  haml :reading
end


get '/about' do
  @description = 'If you want to know more about me this is the place to go'
  haml :reading
end

get '/stylesheets/:name.css' do
  sass :"stylesheets/#{params[:name]}"
end
