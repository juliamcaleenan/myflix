require 'spec_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "input is valid" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user record" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign_in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "input is invalid" do
      before { post :create, user: { email_address: "bob@example.com" } }

      it "does not create a user record" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets the @user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end