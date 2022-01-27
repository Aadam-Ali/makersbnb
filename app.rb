require 'sinatra'
require 'sinatra/base'
require_relative 'lib/database_connection'
require_relative 'lib/properties'
require_relative 'lib/bookings'
require_relative 'lib/users'

DatabaseConnection.setup

class Makersbnb < Sinatra::Base
  
  enable :sessions
  
  get "/" do
    redirect '/register'
  end
  
  get '/register' do
    erb(:'users/new')
  end

  post '/register' do
    session[:user] = Users.create(params[:email], params[:password], params[:username])
    redirect '/spaces'
  end

  get '/login' do 
    erb(:'users/login')
  end

  post '/login' do 
    session[:user] = Users.find_by_email(params[:login_email])
    redirect '/spaces'
  end

  get '/spaces' do
    @user = session[:user]
    @spaces = Properties.all 
    erb :'spaces/spaces'
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    Properties.create(params[:name], params[:description], params[:price], session[:user].id, params[:available_from], params[:available_to])
    redirect '/spaces'
  end
  
  get '/spaces/:id' do
    @space = Properties.find_by_id(params[:id])
    erb(:'spaces/details')
  end

  post '/bookings/new' do
    Bookings.create(params[:property_id], session[:user].id, '2022-02-02')
    redirect '/successful'
  end

  get '/successful' do
    erb(:'bookings/success')
  end
end
