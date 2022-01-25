require 'sinatra'
require 'sinatra/base'
require_relative 'lib/database_connection'

DatabaseConnection.setup

class Makersbnb < Sinatra::Base
  
  enable :sessions
  
  get "/" do
    'Hello'
  end

  get '/spaces' do
    "Hi #{session[:username]}"
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/spaces'
  end

end
