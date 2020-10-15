require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
  describe "get#index" do

    it "should render the users index" do
      get :index

      expect(response).to render_template(:index)
    end
    
  end       

  describe "get#show" do
    it "should render the user's show page" do
      user = create :user
      get :show, params: { id: user.id }

      expect(response).to render_template(:show)
    end
  end

  describe "get#new" do
    it "should render the new user form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post#create" do
    # before :each do
    #   create :user

    # end

    let(:valid_params) { { user: { username: "Daniel", password: "starwars" } } }
    let(:invalid_params) { { user: { email: "whatever", password: "starwars" } } }

    context "with valid parameters" do 
      it "redirects to user show page" do
        # debugger
        post :create, params: valid_params
        # debugger
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "renders the new user template" do
        post :create, params: invalid_params

        expect(response).to render_template(:new)
        # expect(response).to have_http_status(422)
        expect(flash[:errors]).to be_present
      end
    end

  end

end