require 'pry'
require 'rack-flash'

class StatesController < ApplicationController
  use Rack::Flash

  get '/states' do
    if logged_in?
        @user = current_user
        @states = current_user.states

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
          params[:state_name].each do |state_name|
          @state = State.find_or_create_by(:state_name => state_name)
            if @state.users.include?(current_user)
              flash[:message] = "You have already added this state."
              erb :'/states'
            else
              @state.users << current_user
            end
          end
          redirect "/states"
      else
        redirect to "/states/new"
      end
  end



  get '/states/:id' do
    if logged_in?
      @state = State.find_by_id(params[:id])
        if @state != nil
          erb :'/states/show'
        else
          redirect to '/states'
        end
    else
      redirect to '/login'
    end
  end

  get '/states/:id/add_details' do
    if logged_in?
      @state = State.find_by_id(params[:id])
      if @state && current_user
        erb :'states/add_details'
      else
        redirect to '/states'
      end
    else
      redirect to '/login'
    end
  end

  post '/states/:id/add_details' do
    if logged_in?
        if UserState.exists?
          @userstate = UserState.find_or_initialize_by(state_id: params[:id], user_id: current_user.id)
          @userstate.memory = params[:memory]
          @userstate.save
          @state = State.find_by_id(params[:id])
          redirect to "/states/#{@state.id}"
        else !UserState.exists?
          flash[:message] = "Error, you have not added this state to your list yet. Please add and then come back."
          erb :'/states'
        end
    else
      redirect to '/login'
    end
  end


  get '/states/:id/edit' do
    if logged_in?
      @state = State.find_by_id(params[:id])
        if @state && current_user
          erb :'states/edit'
        else
          redirect to '/states'
        end
    else
      redirect to '/login'
    end
  end


  patch '/states/:id/edit' do
    @state = State.find_by_id(params[:id])
    @userstate = UserState.find_by(state_id: params[:id], user_id: current_user.id)
      if params[:memory] != ""
        @userstate.update(:memory => params[:memory])
        redirect to "/states/#{@state.id}"
      else
        redirect to "/states/#{@state.id}/edit"
      end
  end


  delete '/states/:id/add_details/delete' do
    if logged_in?
      @userstate = UserState.find_or_initialize_by(state_id: params[:id], user_id: current_user.id)
      @userstate.memory = params[:memory]
      @userstate.save
        if @userstate.memory && current_user
            @userstate.memory.delete
        end
      @state = State.find_by_id(params[:id])
      redirect to "/states/#{@state.id}"
    else
      redirect to '/login'
    end
  end

  delete '/states/:id/delete' do
    if logged_in?
      @userstate = UserState.find_by(state_id: params[:id],user_id: current_user.id)
        if @userstate && current_user
            @userstate.delete
        end
      redirect to '/states'
    else
      redirect to '/login'
    end
  end

end
