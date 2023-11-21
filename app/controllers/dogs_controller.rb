class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog-params)
    if @dog.save
      redirect dog_path(@dog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :description, :address)
  end
end
