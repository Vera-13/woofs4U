class BookingsController < ApplicationController
  def new
    @dog = Dog.find(params[:dog_id])
    @dog.user = current_user
    @booking = Booking.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = current_user
    if @booking.save
      redirect_to dog_path(@dog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dog_path(@bookmark.dog), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :dog_id)
  end
end
