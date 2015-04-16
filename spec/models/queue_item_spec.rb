require 'spec_helper'

describe QueueItem do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#rating" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:queue_item) {Fabricate(:queue_item, user: user, video: video) }

    it "returns the rating from the review of the video by the current user if present" do
      review = Fabricate(:review, user: user, video: video, rating: 3)
      expect(queue_item.rating).to eq(3)
    end
    
    it "returns nil if the current user has not reviewed the video" do
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#rating=" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:queue_item) {Fabricate(:queue_item, user: user, video: video) }

    it "changes the rating of the review if the review is present" do
      review = Fabricate(:review, video: video, user: user, rating: 5)
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
    end

    it "clears the rating of the review if the review is present" do
      review = Fabricate(:review, video: video, user: user, rating: 5)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a new review with the rating if the review is not present" do
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
  end
end