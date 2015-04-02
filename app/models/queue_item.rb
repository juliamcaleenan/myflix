class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id

  def rating
    video.reviews.find_by(user: user).rating if video.reviews.find_by(user: user)
  end

end