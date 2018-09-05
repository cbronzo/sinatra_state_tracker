require 'pry'
class StatesController < ApplicationController

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
                "You have already added this state."

              else
                @state.users << current_user
                # binding.pry
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
          redirect to "/states/#{@state.id}"
        else
          "Error, you have not added this state to your list yet. Please add and then come back."
          redirect to '/states'
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


    patch '/states/:id' do
      @state = State.find_by_id(params[:id])
        if params[:memory] != ""
          @state.update(:memory => params[:state][:memory])
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
