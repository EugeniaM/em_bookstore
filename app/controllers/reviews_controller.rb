class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:rate]
  def index
  end

  def create
    @review = Review.new(review_params) do | review |
      review.book_id = params[:book_id]
      review.user_id = current_user.id
      review.score = params[:score]
    end

    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(params[:book_id]) }
      else
        format.html { render :create }
      end
    end
  end

  def review_params
    params.require(:review).permit(:title, :text)
  end
end
