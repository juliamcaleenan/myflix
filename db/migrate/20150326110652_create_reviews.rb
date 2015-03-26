class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :rating
      t.integer :user_id
      t.integer :video_id
      t.timestamps
    end
  end
end
