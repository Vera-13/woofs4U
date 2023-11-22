class ReviewsController < ApplicationController
  def new
    @dog = Dog.find(params[:dog_id])
    @dog.user = current_user
    @review = Review.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @review = Review.new(review_params)
    @review.dog = @dog
    @review.user = current_user
    if @review.save
      redirect_to dog_path(@dog)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to dog_path(@review.dog), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :user_id, :dog_id)
  end
end
