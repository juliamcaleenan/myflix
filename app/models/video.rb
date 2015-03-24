class Video < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    search_term.blank? ? [] : where("title ILIKE ?", "%#{search_term}%").order(created_at: :desc)
  end
end