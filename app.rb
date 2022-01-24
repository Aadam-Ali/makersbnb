require 'sinatra'
require 'sinatra/base'
require_relative 'lib/database_connection'

DatabaseConnection.setup

class Makersbnb < Sinatra::Base
  get "/" do
    'Hello'
  end
end 