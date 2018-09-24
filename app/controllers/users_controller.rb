require 'pry'
require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users' do
    @user_items_count = UserState.group(:user_id).count
    @users = User.all
    erb :'/users/index'
  end

  get '/signup' do
    if logged_in?
      redirect to '/states'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" ||  params[:password] == "" || params[:name] == ""
      flash[:message] = "All fields are required! Please try again."
      erb :'users/create_user'
    elsif User.find_by(:email => params[:email])
        flash[:message] = "Email already in use. Please try again."
        erb :'users/create_user'
    elsif User.find_by(:username => params[:username])
      flash[:message] = "Username already exists, please try again."
      erb :'users/create_user'
    else
      create_user_and_login
      redirect :'/states'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/states'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect :'/states'
      else
        flash[:message] = "No user found. Please try again or create an account."
        erb :'users/create_user'
     end
  end

  get '/logout' do
    if logged_in?
        session.clear
        redirect to '/login'
    else
      redirect to '/'
    end
  end

end

#   # edit user
    #   get '/users/:slug/edit' do
    #     if logged_in?
    #       @user = User.find_by_slug(params[:slug])
    #       if @user && current_user
    #         erb :'users/edit'
    #       end
    #     else
    #       redirect to '/login'
    #     end
    #   end
    #
    #
    #   # #to update a user
    #   patch '/users/:slug' do
    #     @user = User.find_by_slug(params[:slug])
    #     binding.pry
    #       if params[:user] != ""
    #         @user.update(:username => params[:user][:username])
    #         @user.update(:name => params[:user][:name])
    #         @user.update(:email => params[:user][:email])
    #         @user.update(:password_digest => params[:user][:password_digest])
    #           redirect to "/users/#{@user.slug}"
    #       else
    #         redirect to "/users/#{@user.slug}/edit"
    #       end
    #   end
    #
    #
    #
    #    #delete a user
    #   delete '/users/:slug/delete' do
    #     if logged_in?
    #       @user = User.find_by_slug(params[:slug])
    #         if @user && current_user
    #             @user.destroy
    #         end
    #       redirect to '/'
    #     else
    #       redirect to '/signup'
    #     end
    # end


      #   @user = User.find_by_slug(params[:slug])
      #     if @user
      #         @user.delete
      #     end
      #   redirect '/users'
      # end


      # get '/users/:slug' do
      #   if logged_in?
      #     @user = User.find_by_slug(params[:slug])
      #       if @user.slug !=nil
      #         erb :'/states'
      #       else
      #         redirect '/users'
      #       end
      #   else
      #     redirect '/users'
      #   end
      # end
