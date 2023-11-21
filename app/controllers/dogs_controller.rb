class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def new
    @user = User.find(params[:id])
    @dog = Dog.new
  end

  def create
    @user = User.find(params[:id])
    @dog = Dog.new(dog_params)
    @dog.user = @user
    if @dog.save
      redirect dog_path(@dog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect dog_path(@dog)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
    redirect_to dogs_path, status: :see_other
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :description, :address, :user_id)
  end
end
