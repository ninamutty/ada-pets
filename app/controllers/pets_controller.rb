class PetsController < ApplicationController
  def index
    pets = Pet.all

    #pets = Pet.select(:name, :id, :human, :age)
    # render :json => pets.as_json(:only => [:name, :id, :human, :age])
    render :json => pets.as_json(:only => [:name, :id, :human, :age], :status => :ok)
  end

  def show
    ## Getting a specific pet back
    pet = Pet.find_by(id: params[:id])

    #if pet
      render :json => pet, :only => [:name, :id, :human, :age], :status => :ok
    # else
    #   render :json => [], :status => :no_content
    # end
  end

  def search
    pets = Pet.where(name: params[:query].capitalize)
    unless pets.empty?
      render :json => pet, :only => [:name, :id, :human, :age], :status => :ok
    else
      render :json => [], :status => :no_content
    end
  end
end
