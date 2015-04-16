class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order "position" }

  has_secure_password validations: false
  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address

  def update_queue_items_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end
end