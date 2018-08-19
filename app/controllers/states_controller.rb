require 'pry'

class StatesController < ApplicationController


  get '/states' do
    if logged_in?
      @user = current_user
      @states = State.all
      erb :'states/states'
    else
      redirect to '/login'
    end
  end


  get '/states/new' do
    if logged_in?
      erb :'/states/create'
    else
      redirect to '/login'
    end
  end


  post '/states' do
      if logged_in? && params[:state_name] != ""
        @State = State.create(:state_name => params[:state_name])
        @state.user_id = current_user.id
        @state.save
      else
        binding.pry
        redirect to "/states/new"
      end
    end


  get '/states/:id' do
    binding.pry
    if logged_in?
      @state = State.find_by_id(params[:id])
      erb :'/states/show'
    else
      redirect to '/login'
    end
  end

  get '/states/:id/edit' do
    if logged_in?
      @state = State.find_by_id(params[:id])
      if @state && @state.user == current_user
        erb :'states/edit'
      else
        redirect to '/states'
      end
    else
      redirect to '/login'
    end
  end


    patch '/states/:id' do
      @state = State.find_by_id(params[:id])
        if params[:state_name] != ""
          @state.update(:state_name => params[:state_name])
          redirect to "/states/#{@state.id}"
        else
          redirect to "/states/#{@state.id}/edit"
        end
    end

    delete '/states/:id/delete' do
      if logged_in?
        @state = State.find_by_id(params[:id])
          if @state && @state.user == current_user
              @state.delete
          end
        redirect to '/states'
      else
        redirect to '/login'
      end
  end


end


# #define routes
#
#   #index page
#   get '/states' do
#     @states = State.all
#   end
#
#   #form to create state?
#   get '/states/new' do
#     @states = State.all
#     erb :'states/new'
#   end
#
#
#   #get one state
#   get '/states/:id' do
#     @state = State.find_by_id(params[:id])
#     # binding.pry
#     erb :'states/show'
#   end
#
#
#
#   #to edit a state
#   get '/states/:id/edit' do
#
#   end
#
#   #to create a state?
#   post '/states' do
#     @state = State.new(params["state"])
#
#     if @state.save
#       redirect '/states/#{@state.id}'
#     else
#       erb :'/states/new'
#     end
#
#   end
#
#   #to update a state
#   patch '/states/:id' do
#
#   end
#
#
#
#   #delete a state
#   delete '/states/:id' do
#
#   end
#
#
