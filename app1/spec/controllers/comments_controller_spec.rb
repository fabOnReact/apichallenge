require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user)} 
  let(:comment) { instance_double("comment")}
  let(:comment_factory) { FactoryBot.create(:comment) }
  let(:comment_stub) { FactoryBot.build_stubbed(:comment) }
  let(:comment_attributes) { FactoryBot.attributes_for(:comment)}
  let(:valid_params) { {comment: { message: 'test', description: 'some test'}}}

  login_user

  describe "GET #index" do it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      allow(Comment).to receive(:find).and_return comment
      get :edit, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do 
      before(:each) do 
        expect(Comment).to receive(:new).and_return comment_stub
        allow(comment_stub).to receive(:save).and_return true
      end
      
      it "redirects to comments/show page" do
        get :create, params: valid_params, as: :html
        expect(response).to redirect_to(comment_path(comment_stub))
      end

      it "render the json response" do
        post :create, params: valid_params, as: :json
        expect(response).to have_http_status(:created)
        expect(json_response[:message]).to eql(comment_stub.message) 
      end
    end

    context "with invalid parameters" do 
      it "re-renders the new template" do 
        get :create, params: valid_params, as: :html
        expect(response).to render_template(:new)
      end

      it "renders the errors in the json response body" do 
        get :create, params: valid_params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:errors]).not_to be_empty
      end
    end
  end
end
