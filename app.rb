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
    @user
    # @user replacing @username = session[:username] with @user.name
    @spaces = Properties.all 
    erb :'spaces/spaces'
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    @user = Users.create(params[:email], params[:password], params[:username])
    # session[:username] = params[:username]
    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space = Properties.find_by_id(params[:id])
    @user
    # @user replacing @username = session[:username] with @user.name
    erb(:'spaces/details')
  end

  post '/bookings/new' do
    Bookings.create(params[:property_id], session[:username], '2022-02-02')
    redirect '/successful'
  end

  get '/successful' do
    erb(:'bookings/success')
  end

end
