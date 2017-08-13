class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:rate]
  def index
  end

  def create
    @review = Review.new(review_params) do | review |
      review.book_id = params[:book_id]
      review.user_id = current_user.id
      review.score = params[:score] || 0
    end

    respond_to do |format|
      errors = []
      if !@review.save
        errors = @review.errors.full_messages
      end
      book = Book.find(params[:book_id])
      book.update({review_errors: errors})
      format.html { redirect_to book_path(params[:book_id]) }
    end
  end

  def review_params
    params.require(:review).permit(:title, :text)
  end
end
