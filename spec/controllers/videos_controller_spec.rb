require 'spec_helper'

describe VideosController do

  describe "GET show" do
    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)    
    end

    it "sets the @reviews variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video, user: Fabricate(:user))
      review2 = Fabricate(:review, video: video, user: Fabricate(:user))
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])    
    end

    it "redirects to root_path for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end
  end

  describe "GET search" do
    it "sets the @videos variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      family_guy = Fabricate(:video, title: "Family Guy")
      get :search, search_term: "fam"
      expect(assigns(:videos)).to eq([family_guy])
    end

    it "redirects to root_path for unauthenticated users" do
      get :search
      expect(response).to redirect_to root_path
    end
  end
end