require 'sinatra'
require 'sinatra/base'
require_relative 'lib/database_connection'

DatabaseConnection.setup

class Makersbnb < Sinatra::Base
  get "/" do
    'Hello'
  end

  get '/sessions/new' do
    "Type in your name here" 
  end

end
