# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    if review_form.save
      redirect_to_book(type: :notice, message: t('books.partials.write_review.good_create'))
    else
      redirect_to_book(type: :alert, message: review_form.errors.full_messages.join(', '))
    end
  end

  private

  def review_form
    @review_form ||= ReviewForm.new(review_new, permitted_params)
  end

  def review_new
    @review_new ||= Review.new(permitted_params)
  end

  def redirect_to_book(type:, message:)
    flash[type] = message
    redirect_to book_path(permitted_params[:book_id])
  end

  def permitted_params
    params.require(:review).permit(:title, :text, :rating, :book_id).merge(user_id: current_user.id)
  end
end
