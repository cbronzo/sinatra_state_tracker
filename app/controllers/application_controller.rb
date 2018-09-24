require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
   def logged_in?
     !!session[:id]
   end

   def current_user
     User.find(session[:id])
   end
 end

 def create_user_and_login
   @user = User.create(params)
   session[:id] = @user.id
 end



end
