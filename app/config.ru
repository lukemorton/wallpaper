require 'bundler'
require 'sinatra/base'

APP_ROOT = File.dirname(__FILE__)
DB_PATH = APP_ROOT + '/app.db'

require APP_ROOT + '/wall/controller'
require APP_ROOT + '/../mapping/lib/wallpaper/sqlite_mappers/post'
require APP_ROOT + '/../domain/lib/wallpaper/wall/interaction'
require APP_ROOT + '/../domain/lib/wallpaper/wall/posts'
require APP_ROOT + '/../domain/lib/wallpaper/validation_exception'

Wallpaper::SQLiteMappers::Post.new(DB_PATH).create_table!

class Application < Sinatra::Base
  set :public_folder, APP_ROOT + '/static'

  def wall_controller()
    di = {
      :request  => request,
      :response => response,
      :mappers  => {:post => Wallpaper::SQLiteMappers::Post.new(DB_PATH)},

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
