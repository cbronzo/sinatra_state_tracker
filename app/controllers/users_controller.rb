require 'pry'
class UsersController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'/users/index'

  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
    end

    get '/signup' do
      if logged_in?
        redirect to '/states'
      end
      erb :'/users/create_user'
    end

    post '/signup' do
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to '/signup'
      elsif
        User.find_by(:username => params[:username])
        "Duplicate username, please try again."
        redirect to '/signup'
      else
        @user = User.create(params)
        session[:id] = @user.id
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
            redirect to '/signup'
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




end
