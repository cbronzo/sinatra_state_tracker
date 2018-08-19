class UsersController < ApplicationController


    #users index route
    get '/users' do
      @users = User.all
      erb :'users/index'
    end

    #create new user
    get '/users/new' do
      erb :'users/new'
    end

    #submit new user
    post '/users/new'
    @user = User.new(params["user"])
      if @user.save
        redirect "/users"
      else
        redirect "/users/new"
      end
    end

    #edit user
    get '/users/:id/edit'
      @user = User.find_by_id(params[:id])
      erb :'users/edit'
    end

    #to update a user
    patch '/users/:id' do
    end


    #delete a user
    delete '/userss/:id' do

    end

end
