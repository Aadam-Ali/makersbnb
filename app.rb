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
    @new_user
    # @user replacing @username = session[:username] with @user.name
    @existing_user
    # for a user who is loggin in vs signing up 
    @spaces = Properties.all 
    erb :'spaces/spaces'
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    @new_user = Users.create(params[:email], params[:password], params[:username])
    # session[:username] = params[:username]
    redirect '/spaces'
  end

  get '/login/new' do 
    erb (:'sessions/login')
  end

  post '/login' do 
    @existing_user = Users.find_by_email(params[:login_email])
    redirect '/spaces'
  end
  get '/spaces/new' do
    erb(:'spaces/new')
  end
  
  get '/spaces/:id' do
    @space = Properties.find_by_id(params[:id])
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
