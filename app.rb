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
    @owner_name = Users.find_by_id(@space.owner_id).name
    erb(:'spaces/details')
  end

  post '/bookings/new' do
    redirect '/register' if session[:user].nil?
    if Bookings.create(params[:property_id], session[:user].id, params[:booking_date])
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
    @properties = @bookings.map { |booking| Properties.find_by_id(booking.property_id)}
    @user = session[:user]
    erb(:'/users/bookings')
  end

  get '/users/requests' do
    @bookings = Bookings.find_incoming_bookings( session[:user].id)
    @properties = @bookings.map { |booking| Properties.find_by_id(booking.property_id)}
    @user = session[:user]
    erb(:'/users/requests')
  end

end