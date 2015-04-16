require 'spec_helper'

describe VideosController do

  describe "GET show" do
    it "sets the @video variable for authenticated users" do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)    
    end

    it "sets the @reviews variable for authenticated users" do
      set_current_user
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, user: Fabricate(:user))
      review2 = Fabricate(:review, video: video, user: Fabricate(:user))
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])    
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: Fabricate(:video).id }
    end
  end

  describe "GET search" do
    it "sets the @videos variable for authenticated users" do
      set_current_user
      family_guy = Fabricate(:video, title: "Family Guy")
      get :search, search_term: "fam"
      expect(assigns(:videos)).to eq([family_guy])
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :search }
    end
  end
end