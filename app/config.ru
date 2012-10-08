require 'bundler'
require 'sinatra/base'
require File.dirname(__FILE__) + '/wall/controller'
require File.dirname(__FILE__) + '/wall/post_mappers/sqlite'
require File.dirname(__FILE__) + '/../domain/lib/wallpaper/wall/interaction'
require File.dirname(__FILE__) + '/../domain/lib/wallpaper/wall/posts'
require File.dirname(__FILE__) + '/../domain/lib/wallpaper/validation_exception'

Wall::PostMappers::SQLite.new.create_table!

class Application < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/static'

  def wall_controller()
    di = {
      :request  => request,
      :response => response,
      :mappers  => {:post => Wall::PostMappers::SQLite.new},

      :interaction => Wallpaper::Wall::Interaction,
      :posts       => Wallpaper::Wall::Posts,

      :validation_exception => Wallpaper::ValidationException,
    }
    Wall::Controller.new(di)
  end

  get '/' do
    wall_controller.view
  end

  post '/' do
    wall_controller.action
  end
end

run Application