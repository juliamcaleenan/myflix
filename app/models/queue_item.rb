class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id
  validates_numericality_of :position, only_integer: true

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      new_review = Review.new(user: user, video: video, rating: new_rating)
      new_review.save(validate: false)
    end
  end

  private

  def review
    @review ||= video.reviews.find_by(user: user)
  end
end