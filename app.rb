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
    @username = session[:username]
    # @spaces = Spaces.all 
    @spaces = [{name:'House', description: 'Lovely House', id: '1'}, {name: 'Cottage', description: 'Lovely Cottage', id: '2'}]
    erb :'spaces/spaces'
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    session[:username] = params[:username]
    redirect '/spaces'
  end

  get '/spaces/:id' do
    # space = Space.find_by_id(params[:id])
    @space = [ { name:'House', description: 'Lovely House', owner: 'Lovely Owner', price: '80' } ]
    erb(:'spaces/details')
  end

end
