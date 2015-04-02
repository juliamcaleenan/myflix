class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }
  has_many :queue_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    search_term.blank? ? [] : where("title ILIKE ?", "%#{search_term}%").order(created_at: :desc)
  end

  def average_rating
    reviews.average(:rating).round(1) if reviews.count > 0
  end
end