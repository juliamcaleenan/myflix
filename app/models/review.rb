class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :rating, :description
  validates_uniqueness_of :video_id, scope: :user_id
end