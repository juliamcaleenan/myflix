require 'spec_helper'

describe User do

  it { should validate_presence_of(:email_address) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email_address) }
  it { should have_secure_password }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items).order("position") }

  describe "#queued_video?" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "returns true when the video is in the user's queue" do
      Fabricate(:queue_item, video: video, user: user)
      expect(user.queued_video?(video)).to be_truthy
    end

    it "returns false when the video is not in the user's queue" do
      expect(user.queued_video?(video)).to be_falsey
    end
  end
end