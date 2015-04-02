require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template if user is not authenticated" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page if user is already authenticated" do
      session[:user_id] = Fabricate(:user).id 
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "user enters a valid email address and password" do
      let(:bob) { Fabricate(:user) }
      before { post :create, email_address: bob.email_address, password: bob.password }

      it "creates a session for the user" do        
        expect(session[:user_id]).to eq(bob.id)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "sets the success notice" do
        expect(flash[:success]).to_not be_blank
      end
    end

    context "user enters an invalid email address or password" do
      let(:bob) { Fabricate(:user) }
      before { post :create, email_address: bob.email_address, password: "" }

      it "does not create a session for the user" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign_in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets the danger notice" do
        expect(flash[:danger]).to_not be_blank
      end
    end
  end

  describe "GET destroy" do
    before do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "destroys the user's session" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root_path" do
      expect(response).to redirect_to root_path
    end

    it "sets the success notice" do
      expect(flash[:success]).to_not be_blank
    end
  end
end