require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC")}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if there are no matches" do
      family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.")
      modern_family = Video.create(title: "Modern Family", description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.")
      expect(Video.search_by_title("South Park")).to eq([])
    end

    it "returns an array of one video if there is one exact match" do
      family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.")
      modern_family = Video.create(title: "Modern Family", description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.")
      expect(Video.search_by_title("Family Guy")).to eq([family_guy])
    end

    it "returns an array of one video if there is one partial match" do
      family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.")
      modern_family = Video.create(title: "Modern Family", description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.")
      expect(Video.search_by_title("mod")).to eq([modern_family])
    end

    it "returns an array of all matches ordered by created_at" do
      family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.", created_at: 1.day.ago)
      modern_family = Video.create(title: "Modern Family", description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.")
      expect(Video.search_by_title("fam")).to eq([modern_family, family_guy])
    end

    it "returns an empty array for a search with an empty string" do
      family_guy = Video.create(title: "Family Guy", description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.", created_at: 1.day.ago)
      modern_family = Video.create(title: "Modern Family", description: "Three different, but related families face trials and tribulations in their own uniquely comedic ways.")
      expect(Video.search_by_title("")).to eq([])
    end
  end

  describe "#average_rating" do
    it "calculates the average rating of a video (from its reviews) rounded to 1 decimal place" do
      video = Fabricate(:video)
      video.reviews << Fabricate(:review, rating: 5)
      video.reviews << Fabricate(:review, rating: 4)
      video.reviews << Fabricate(:review, rating: 4)
      expect(video.average_rating).to eq(4.3)
    end
  end
end