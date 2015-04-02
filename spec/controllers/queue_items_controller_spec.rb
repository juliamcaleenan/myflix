require 'spec_helper'

describe QueueItemsController do

  describe "GET index" do
    it "sets the @queue_items variable to the queue items of the signed in user" do
      user = Fabricate(:user)
      family_guy = Fabricate(:video, title: "Family Guy")
      futurama = Fabricate(:video, title: "Futurama")
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user, video: family_guy)
      queue_item2 = Fabricate(:queue_item, user: user, video: futurama)
      queue_item3 = Fabricate(:queue_item, user: Fabricate(:user), video: futurama)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])    
    end

    it "redirects to root_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    
    context "user is signed in" do
      before { session[:user_id] = user.id }

      it "creates a queue item" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue item associated with the video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end

      it "creates a queue item associated with the user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(user)
      end

      it "redirects to the my queue page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end

      it "puts the video as the last one in the queue" do
        Fabricate(:queue_item, video: Fabricate(:video), user: user)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq(2)
      end

      it "does not add the video to the queue if it is already in the queue" do
        Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "user is not signed in" do
      it "redirects to root_path" do
        post :create, video_id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    context "user is signed in" do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      it "deletes the queue item" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "redirects to the my queue page" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end

      it "updates the positions of the remaining queue items" do
        queue_item1 = Fabricate(:queue_item, user: user, video_id: 1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, video_id: 2, position: 2)
        queue_item3 = Fabricate(:queue_item, user: user, video_id: 3, position: 3)
        delete :destroy, id: queue_item1.id
        expect(QueueItem.count).to eq(2)
        expect(queue_item2.reload.position).to eq(1)
        expect(queue_item3.reload.position).to eq(2)
      end

      it "does not delete a queue item from another user's queue" do
        another_queue_item = Fabricate(:queue_item, user: Fabricate(:user))
        delete :destroy, id: another_queue_item.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "user is not signed in" do
      it "redirects to root_path" do
        delete :destroy, id: Fabricate(:queue_item).id
        expect(response).to redirect_to root_path
      end
    end
  end

end