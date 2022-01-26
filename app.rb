require 'sinatra'
require 'sinatra/base'
require_relative 'lib/database_connection'
require_relative 'lib/properties'
require_relative 'lib/bookings'

DatabaseConnection.setup

class Makersbnb < Sinatra::Base
  
  enable :sessions
  
  get "/" do
    'Hello'
  end

  get '/spaces' do
    @username = session[:username]
    @spaces = Properties.all 
    erb :'spaces/spaces'
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/spaces'
  end
  get '/spaces/new' do
    erb(:'spaces/new')
  end
  
  get '/spaces/:id' do
    @space = Properties.find_by_id(params[:id])
    @username = session[:username]
    erb(:'spaces/details')
  end

  post '/bookings/new' do
    Bookings.create(params[:property_id], session[:username], '2022-02-02')
    redirect '/successful'
  end

  get '/successful' do
    erb(:'bookings/success')
  end


  post '/spaces/new' do
    Properties.create(params[:name], params[:description], params[:price], session[:username] )
    redirect '/spaces'
  end


end
