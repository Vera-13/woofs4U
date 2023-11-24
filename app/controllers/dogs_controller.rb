class DogsController < ApplicationController
  def index
    @dogs = Dog.all
    if params[:query].present?
      @dogs = @dogs.global_search(params[:query])

    end
  end

  def show
    @dog = Dog.find(params[:id])
    @marker =
      if @dog.latitude && @dog.longitude
        {
          lat: @dog.latitude,
          lng: @dog.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {dog: @dog}),
          marker_html: render_to_string(partial: "marker")
        }
      end
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user = current_user

    if @dog.save
      redirect_to dog_path(@dog)
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
      redirect_to dog_path(@dog)
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
    params.require(:dog).permit(:name, :description, :address,:photo, :user_id, )
  end
end
