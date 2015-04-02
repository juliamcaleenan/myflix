class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items.order(:position)
  end

  def create
    video = Video.find(params[:video_id])
    queue_item = video.queue_items.create(user: current_user, position: new_queue_item_position)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if queue_item.user == current_user
    update_queue_items_positions
    redirect_to my_queue_path
  end

  private

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def update_queue_items_positions
    queue_items = current_user.queue_items.order(:position)
    queue_items.each_with_index do |queue_item, index|
      queue_item.update(position: index + 1)
    end
  end

end