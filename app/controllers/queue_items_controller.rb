class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = video.queue_items.create(user: current_user, position: new_queue_item_position)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if queue_item.user == current_user
    current_user.update_queue_items_positions
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.update_queue_items_positions
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Please enter valid numbers"
    end
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update!(position: queue_item_data[:position], rating: queue_item_data[:rating]) if queue_item.user == current_user
      end
    end
  end
end