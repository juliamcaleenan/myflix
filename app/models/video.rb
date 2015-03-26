class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order "created_at DESC" }

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    search_term.blank? ? [] : where("title ILIKE ?", "%#{search_term}%").order(created_at: :desc)
  end

  def average_rating
    sum = 0
    count = reviews.count.to_f
    reviews.all.each { |review| sum += review.rating }
    average = sum / count
    average.round(1)
  end
end