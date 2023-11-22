class BookingsController < ApplicationController
  def new
    @booking = Booking.find(params[:id])
    @booking = Booking.new
  end

  def create
    @dog = Dog.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.save
    redirect_to dog_path(@dog)
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
