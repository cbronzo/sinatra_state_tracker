require 'pry'

class StatesController < ApplicationController

#define routes

  #index page
  get '/states' do

  end

  #form to create state?
  get '/states/new' do
    erb :'states/new'
  end


  #get one state
  get '/states/:id' do

    erb :'states/show'
  end

  #to edit a state
  get '/states/:id/edit' do

  end



  #to update a state
  patch '/states/:id' do

  end

  #to create a state?
  post '/states' do
    binding.pry

    @state = State.new(name: params[:name], region: params[:region], abbreviation: params[:abbreviation])

    if @state.save
      redirect '/states/#{@state.id}'
    else
      erb :'/states/new'
    end

  end

  #delete a state
  delete '/states/:id' do

  end




end
