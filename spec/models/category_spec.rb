require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    it "returns an array of the six most recent videos in the category in reverse chronological order by created_at" do
      category = Category.create(name: "Test Category")
      video1 = Video.create(title: "Test1", description: "A description of Test1", created_at: 7.day.ago, category: category)
      video2 = Video.create(title: "Test2", description: "A description of Test2", created_at: 6.day.ago, category: category)
      video3 = Video.create(title: "Test3", description: "A description of Test3", created_at: 5.day.ago, category: category)
      video4 = Video.create(title: "Test4", description: "A description of Test4", created_at: 4.day.ago, category: category)
      video5 = Video.create(title: "Test5", description: "A description of Test5", created_at: 3.day.ago, category: category)
      video6 = Video.create(title: "Test6", description: "A description of Test6", created_at: 2.day.ago, category: category)
      video7 = Video.create(title: "Test7", description: "A description of Test7", created_at: 1.day.ago, category: category)   
      expect(category.recent_videos).to eq([video7, video6, video5, video4, video3, video2])
    end
    it "returns an array of all videos in the category, if there are fewer than six videos in that category, in reverse chronological order" do
      category1 = Category.create(name: "Test Category")
      category2 = Category.create(name: "Test Category 2")
      video1 = Video.create(title: "Test1", description: "A description of Test1", created_at: 7.day.ago, category: category1)
      video2 = Video.create(title: "Test2", description: "A description of Test2", created_at: 6.day.ago, category: category1)
      video3 = Video.create(title: "Test3", description: "A description of Test3", created_at: 5.day.ago, category: category1)
      video4 = Video.create(title: "Test4", description: "A description of Test4", created_at: 4.day.ago, category: category2)
      expect(category1.recent_videos).to eq([video3, video2, video1])
    end
    it "returns an empty array if the category does not have any videos" do
      category = Category.create(name: "Test Category")
      expect(category.recent_videos).to eq([])
    end
  end
end