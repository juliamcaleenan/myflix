require 'spec_helper'

describe ReviewsController do

  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "input is valid" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      end
      it "creates a review" do
        expect(Review.count).to eq(1)
      end
      it "creates a review associated with the video" do
        expect(Review.first.video).to eq(video)
      end
      it "creates a review associated with the signed in user" do
        expect(Review.first.user).to eq(user)
      end
      it "redirects to the video show page (for that video)" do
        expect(response).to redirect_to video_path(video)
      end
      it "displays a success message" do
        expect(flash[:success]).to_not be_blank
      end
    end

    context "input is invalid" do
      before do
        session[:user_id] = Fabricate(:user).id
        post :create, video_id: video.id, review: { rating: 5 }
      end
      it "does not create a review" do
        expect(Review.count).to eq(0)
      end
      it "renders the video page (for that video)" do
        expect(response).to render_template "videos/show"
      end
      it "sets the @video variable" do
        expect(assigns(:video)).to eq(video)    
      end
      it "sets the @reviews variable" do
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
    end

    context "user is not signed in" do
      it "redirects to root_path" do
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        expect(response).to redirect_to root_path
      end
    end
  end
end