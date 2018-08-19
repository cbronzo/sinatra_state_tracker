require 'pry'
class UsersController < ApplicationController

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/user/show'
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


      # edit user
      get '/users/:id/edit' do
        @user = User.find_by_id(params[:id])
        erb :'users/edit'
      end

      #to update a user
      patch '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
          if @user.update(params["user"])
            redirect "/users"
          else
            redirect "users/#{user.id}/edit"
          end

      end

      #delete a user
      delete '/users/:slug/delete' do
        @user = User.find_by_slug(params[:slug]))
          if @user
            @user.delete
          end
        redirect '/users'
      end


  end
