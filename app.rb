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
    session[:user] = Users.authenticate(params[:login_email], params[:login_password])
    redirect '/spaces'
  end

  get '/spaces' do
    @username = 'Guest'
    @username = session[:user].name unless session[:user].nil?
    @spaces = Properties.all 
    erb :'spaces/spaces'
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    redirect '/register' if session[:user].nil?
    Properties.create(params[:name], params[:description], params[:price], session[:user].id, params[:available_from], params[:available_to])
    redirect '/spaces'
  end
  
  get '/spaces/:id' do
    @space = Properties.find_by_id(params[:id])
    erb(:'spaces/details')
  end

  post '/bookings/new' do
    redirect '/register' if session[:user].nil?
    if Bookings.create(params[:property_id], session[:user].id, '2022-02-02')
      redirect '/successful'
    else
      redirect back
    end
  end

  get '/successful' do
    erb(:'bookings/success')
  end

  get '/users/bookings' do
    @bookings = Bookings.find_by_customer_id( session[:user].id)
    erb(:'/users/bookings')
  end

end