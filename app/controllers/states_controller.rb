require 'pry'
class StatesController < ApplicationController

  get '/states' do
    if logged_in?
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
        @state = State.create(:state_name => params[:state_name])
        @state.users << current_user
          if @state.errors.any?
              "Error, try again"
          else
            redirect "/states"
          end
      else
        redirect to "/states/new"
      end
    end


  get '/states/:id' do
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
      if @state && current_user
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
        if params[:state_name] != "" && @state.update(:state_name => params[:state][:state_name])
          @state.update(:state_name => params[:state][:state_name])
          redirect to "/states/#{@state.id}"
        else
          redirect to "/states/#{@state.id}/edit"
        end
    end

    delete '/states/:id/delete' do
      if logged_in?
        @state = State.find_by_id(params[:id])
          if @state && current_user
              @state.destroy
          end
        redirect to '/states'
      else
        redirect to '/login'
      end
  end
end
