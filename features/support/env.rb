$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', '..')

require 'web'
require 'lib/post_dir'
require 'capybara/cucumber'
Capybara.app = Sinatra::Application.new
